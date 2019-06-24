//
//  Login.swift
//  App
//
//  Created by austin bassett on 2018-11-03.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit
import FirebaseAuth

class Login: UIViewController {


    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    //--------------Save User Info--------------------
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.loginPass()
        }//if
    }
    
    
    
    //-----------------Auth Login---------------------
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        
     /*   if let email = loginEmail.text, let password = loginPassword.text{
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let firebaserError = error{
                    
                print(firebaserError.localizedDescription)
                    return
                    
                }//firebaseError
            
                self.loginPass()
                
            }//Auth.auth()
            
        }//if let email */
        
    }//loginBtnPressed
    
    func loginPass(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginGood:ViewController = storyboard.instantiateViewController(withIdentifier: "Home") as! ViewController
        
        self.present(loginGood, animated: true, completion: nil)
        
    }//loginPass
    
}//Login
