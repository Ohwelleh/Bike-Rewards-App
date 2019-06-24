//
//  Registration.swift
//  App
//
//  Created by austin bassett on 2018-11-03.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class Registration: UIViewController {

    //----------------Outlets------------------------
    
    @IBOutlet weak var taptoChangeBtn: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var createEmail: UITextField!
    @IBOutlet weak var regisPassword: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var usernameCreate: UITextField!
    
    
    //----------------Variables---------------------
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(imageTap)
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        taptoChangeBtn.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    @objc func openImagePicker(_ sender: Any){
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }//openImagePicker
   
    
    
    //-----------Registration----------------
    
    @IBAction func regisBtnPressed(_ sender: Any) {
        
        
        if let email = createEmail.text, let password = regisPassword.text, let username = usernameCreate.text, let image = profilePicture.image{
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let firebaseError = error{
                    
                    print(firebaseError.localizedDescription)
                    return

                }//if let
                
            
                    self.uploadProfileImage(image){ url in
                        
                        if url != nil{
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = username
                            changeRequest?.photoURL = url
                            
                            changeRequest?.commitChanges{ error in
                                if error == nil{
                                    print("User Display name changed!")
                                    
                                    
                                    self.saveProfile(username: username, profileImageURL: url!) { success in
                                        
                                        if success{
                                            
                                            self.dismiss(animated: true, completion: nil)
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                } else {
                                    
                                    print("Error: \(error!.localizedDescription)")
                                    
                                }
                                
                                
                            }
                            
                        } else {
                            
                            
                        }
                   
                        
                        
                    }//uploadProfileImage
            
                self.regiPass()
                
            }//user, error
            
        }// if let (email
        
        
    }//regisBtnPressed
    
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url:URL?) -> ())){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData){ metaData, error in
            if error == nil, metaData != nil{
                
                storageRef.downloadURL{ url, error in
                    
                    completion(url)
                    
                }
                
            }else {
                
                completion(nil)
                
            }
            
            
        }
        
    }//uploadProfileImage
    
    func saveProfile(username: String, profileImageURL: URL,completion: @escaping ((_ success: Bool) -> ())){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            
            ] as [String: Any]
        
        databaseRef.setValue(userObject) { error, ref in
            
            completion(error == nil)
            
            
        }
        
    }//saveProfile
    
    
    func regiPass(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let regiGood:ViewController = storyboard.instantiateViewController(withIdentifier: "Home") as! ViewController
        
        self.present(regiGood, animated: true, completion: nil)
        
        
        
    }
    
    
}//Registration

extension Registration: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }//imagePickerControllerDidCancel
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage{
            
            self.profilePicture.image = pickedImage
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}//extension
