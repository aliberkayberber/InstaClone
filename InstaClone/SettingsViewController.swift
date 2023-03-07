//
//  SettingsViewController.swift
//  InstaClone
//
//  Created by Ali Berkay BERBER on 5.03.2023.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loguotClicked(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Error")
        }
       
        
    }
    

}
