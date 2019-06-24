//
//  SettingsScreen.swift
//  App
//
//  Created by austin bassett on 2018-10-24.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit

class SettingsScreen: UIViewController {

    //-----------------Var/Lets-----------------
    
    let settingDefaults = UserDefaults.standard
    
    let usernmeFieldConstant = "usernameTextFields"
    let nameFieldConstant = "nameTextFields"
    let ageFieldConstant = "ageTextFields"
    let countryFieldConstant = "countryTextFields"
    let heightFieldConstant = "heightTextFields"
    let genderFieldConstant = "genderTextFields"
    let emailFieldConstant = "emailTextFields"
    
    var imagePicker = UIImagePickerController()
    
   // let profileInfo = Profile()
    //------------------Outlets------------------
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    
    @IBOutlet weak var usernmeLbl: UILabel!
    @IBOutlet weak var nmeLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var usernmeTextFiel: UITextField!
    @IBOutlet weak var nmeTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var counrtyTxtField: UITextField!
    @IBOutlet weak var heightTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldValues()
        
        imagePicker.delegate = self
        
        view.addSubview(homeBtn)
        
       
        
    }//viewDidLoad
    
    //------------------------Field Values---------------------------------------
    
    func fieldValues(){
        
        if let usernmeFieldValue = settingDefaults.string(forKey: usernmeFieldConstant){
            
            usernmeTextFiel.text = usernmeFieldValue
            
        }//usernmeFieldValue
        
        if let nameFieldValue = settingDefaults.string(forKey: nameFieldConstant){
            
            nmeTextField.text = nameFieldValue
            
        }//nameFieldValue
        
        if let ageFieldValue = settingDefaults.string(forKey: ageFieldConstant){
            
            ageTextField.text = ageFieldValue
            
        }//ageFieldValue
        
        if let countryFieldValue = settingDefaults.string(forKey: countryFieldConstant){
            
            counrtyTxtField.text = countryFieldValue
            
        }//countryFieldValue
        
        if let heightFieldValue = settingDefaults.string(forKey: heightFieldConstant){
            
            heightTxtField.text = heightFieldValue
            
        }//heightFieldValue
        
        if let genderFieldValue = settingDefaults.string(forKey: genderFieldConstant){
            
            genderTxtField.text = genderFieldValue
            
        }//genderFieldValue
        
        if let emailFieldValue = settingDefaults.string(forKey: emailFieldConstant){
            
            emailTxtField.text = emailFieldValue
            
        }//emailFieldValue
        
        
        
    }//fieldValues
    
    
    
    
    //-------------------------Buttons-------------------------------------------
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        let button = homeBtn
        button?.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        
    }//homeBtnPressed
    
    @objc func goHome(){
        let goHome = ViewController()
        present(goHome, animated: true, completion: nil)
    }//goHome
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        settingDefaults.setValue(usernmeTextFiel.text, forKey: usernmeFieldConstant)
        settingDefaults.setValue(nmeTextField.text, forKey: nameFieldConstant)
        settingDefaults.setValue(ageTextField.text, forKey: ageFieldConstant)
        settingDefaults.setValue(counrtyTxtField.text, forKey: countryFieldConstant)
        settingDefaults.setValue(heightTxtField.text, forKey: heightFieldConstant)
        settingDefaults.setValue(genderTxtField.text, forKey: genderFieldConstant)
        settingDefaults.setValue(emailTxtField.text, forKey: emailFieldConstant)
        
        
        
    
        settingDefaults.set(nmeTextField.text, forKey: "Name")
        settingDefaults.set(ageTextField.text, forKey: "Age")
        settingDefaults.set(counrtyTxtField.text, forKey: "Country")
        settingDefaults.set(heightTxtField.text, forKey: "Height")
        settingDefaults.set(genderTxtField.text, forKey: "Gender")
        settingDefaults.set(usernmeTextFiel.text, forKey:"Username")
        
        
        
        
    }//saveBtnPressed
    
    
    @IBAction func onTapPickProfile(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
        
    }//onTapPickProfile
    
    
    
   
    //---------------------------Data sending to Profile--------------------------
    
}//SettingsScreen

extension SettingsScreen: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            profileImage.image = image
            
        }//if
        
        dismiss(animated: true, completion: nil)
        
    }//imagePickerController
    
}//Extension


