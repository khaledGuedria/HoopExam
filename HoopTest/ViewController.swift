//
//  ViewController.swift
//  HoopTest
//
//  Created by Guedria Khaled on 16/08/2019.
//  Copyright © 2019 Guedria Khaled. All rights reserved.
//

import UIKit
import Firebase

//Login Screen
class ViewController: UIViewController {

    //widgets
    @IBOutlet weak var warningMessage: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //var
    
    
    //Show view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.warningMessage.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Login Action
    @IBAction func loginAction(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                
                self.performSegue(withIdentifier: "AllPhotosSegue", sender: sender)
            }
            else{
               
                 self.warningMessage.isHidden = false
            }
        }
        //performSegue(withIdentifier: "AllPhotosSegue", sender: sender)
        
    }
    

}

