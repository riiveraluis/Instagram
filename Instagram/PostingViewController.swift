//
//  PostingViewController.swift
//  Instagram
//
//  Created by Luis Rivera Rivera on 10/6/22.
//

import UIKit
import AlamofireImage
import Parse

class PostingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func photoTapped(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
    
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af.imageScaled(to: size)
        
        postImageView.image = scaledImage
        
        dismiss(animated: true)
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        guard postImageView.image != nil && postCaptionTextField.text != "" else { return }
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = postCaptionTextField.text!
        post["author"] = PFUser.current()!
        
        let imageData = postImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file

        post.saveInBackground { success, error in
            if success {
                self.dismiss(animated: true)
                print("Post saved")
            } else {
                print("Error could not save post!")
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


