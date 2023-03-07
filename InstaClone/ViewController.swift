//
//  ViewController.swift
//  InstaClone
//
//  Created by Ali Berkay BERBER on 4.03.2023.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", massageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", massageInput: "Username/Password?")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", massageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", massageInput: "Username/Password?")
            
        }
        
        
    }
    
    func makeAlert( titleInput:String, massageInput:String ) {
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

