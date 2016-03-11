//
//  ViewController.swift
//  TracMe
//
//  Created by Archit Rathi on 3/8/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(sender: AnyObject) {
        let ref = Firebase(url: "https://vivid-torch-4452.firebaseio.com/")

        ref.authUser(self.email.text, password: self.password.text) {
            error, authData in
            if (error != nil) {
                // an error occurred while attempting login
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch (errorCode) {
                    case .UserDoesNotExist:
                        print("Handle invalid user")
                    case .InvalidEmail:
                        print("Handle invalid email")
                    case .InvalidPassword:
                        print("Handle invalid password")
                    default:
                        print("Handle default situation")
                    }
                }
            }
             else {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
        
    }
    
    

}

