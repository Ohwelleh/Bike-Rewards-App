//
//  NewPostViewController.swift
//  App
//
//  Created by austin bassett on 2018-12-03.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewPostViewController: UIViewController {
    
    //---------------Outlets------------------
    
    @IBOutlet weak var addPostBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    
    
    
    
    @IBAction func handleAddPostBtn() {
        
        
        guard let userProfile = UserService.currentUserProfile else { return }
        
        let postRef = Database.database().reference().child("posts").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoUrl.absoluteString
            ],
            "text": textView.text,
            "timestamp": [".sv":"timestamp"]
        ] as [String: Any]
        
        
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            
            if error == nil{
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                //Handle The error
                
            }
            
            
        })
        
        
    }//handleAddPostBtn
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  

}
