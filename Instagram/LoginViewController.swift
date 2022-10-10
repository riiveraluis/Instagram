 //
//  LoginViewController.swift
//  Instagram
//
//  Created by Luis Rivera Rivera on 10/6/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let user = PFUser()
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "toFeedSegue", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if user != nil {
                self.performSegue(withIdentifier: "toFeedSegue", sender: self)
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
