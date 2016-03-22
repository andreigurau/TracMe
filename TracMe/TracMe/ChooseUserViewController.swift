//
//  ChooseUserViewController.swift
//  TracMe
//
//  Created by Archit Rathi on 3/10/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit
import Firebase

class ChooseUserViewController: UIViewController {

    let ref = Firebase(url: "https://vivid-torch-4452.firebaseio.com/")
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
            } else {
                // No user is signed in
            }
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let toSend = "dfasdf"
        let chooseMapViewController = segue.destinationViewController as! ChooseMapViewController
        chooseMapViewController.email = toSend
    }
    

    @IBAction func search(sender: AnyObject) {
        ref.observeEventType(.Value, withBlock: { snapshot in
            var s = snapshot.value as! NSDictionary
    
            var t  = self.searchBar.text;
            t = t!.stringByReplacingOccurrencesOfString(".", withString: "t", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            print(s[t!]![t!]!!);
            
            
            var hopperRef = self.ref.childByAppendingPath(t)
            var tracker = ["tracker": s[t!]![t!]!!]
            
            hopperRef.updateChildValues(tracker)
            //var andrei = self.ref.childByAppendingPath(t);
            
            //var user = ["tracker": s[t!]![t!]!!];
            
            //var users = ["guest": user]
            //andrei.childByAppendingPath(t!).setValue(users)
            
            }, withCancelBlock: { error in
                print(error.description)
        })    }
    
}
