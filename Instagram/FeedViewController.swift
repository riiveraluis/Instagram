//
//  FeedViewController.swift
//  Instagram
//
//  Created by Luis Rivera Rivera on 10/6/22.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var numberOfPost: Int!
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       loadPosts()
    }
    
    @objc func loadPosts() {
        numberOfPost = 3
        
        let query = PFQuery(className:"Post")
        query.includeKey("author")
        query.limit = numberOfPost
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { posts, error in
            if posts != nil {
                self.posts.removeAll()
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func loadMorePosts() {
        
        numberOfPost += 3
        
        let query = PFQuery(className:"Post")
        query.includeKey("author")
        query.limit = numberOfPost
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { posts, error in
            if posts != nil {
                self.posts.removeAll()
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.authorNameTopLabel.text = user.username
        cell.authorNameLabel.text = user.username
        cell.photoCaption.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.postImageView.af.setImage(withURL: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts()
        }
    }
}
