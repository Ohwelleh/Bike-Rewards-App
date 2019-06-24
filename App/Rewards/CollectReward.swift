//
//  CollectReward.swift
//  App
//
//  Created by austin bassett on 2018-11-15.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit

class CollectReward: UIViewController{
    
    
    let collectRewards = UserDefaults.standard

    
    //----------Outlets-------------------
    
    @IBOutlet weak var currentPts: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var descLbl: UILabel!
    
    
    let userPoints = UserDefaults.standard.object(forKey: "CurrentValue") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        currentPts.text = userPoints
        descLbl.text = rewardsDesc[myIndex]
        costLbl.text = rewardCost[myIndex]
        
        updatePoints()
        
    }
    
    @IBAction func buyBtnPressed(_ sender: Any) {
        
       currentPts.text = minusPoints(user: userPoints, price:rewardCost[myIndex] )
        collectRewards.set(currentPts.text, forKey:"CurrentValue")
        
    }
    
    func updatePoints(){
        if let updatePts = collectRewards.string(forKey: "CurrentValue"){
            currentPts.text = updatePts
        }
        
        
    }
    
    
    
    func minusPoints(user: String, price: String) -> String{
        
        let userPoints = Double(user)
        let pricePoints = Double(price)
        let difference = userPoints! - pricePoints!
        let total = String(difference)
        
        if pricePoints! > userPoints! {
            
            invalidPoints()
            
            return user
            
        }
            
            return total
        
    }//minusPoints
    
    
    
    //----------Invaild Points--------------------
    
    func invalidPoints(){
        
        //Title of Dialog and Message
        
        let alertController = UIAlertController(title: "Invalid", message: "Invaild Amount of Points", preferredStyle: .alert)
        
        //Confirm action and Do nothing
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default){ (_) in }
        
        //Cancel Action and Do nothing
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (_) in }//cancelAction
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //present dialog box
        self.present(alertController, animated: true, completion: nil)
        
        
    }//invalidPoints
    

    
    
    
}//CollectReward
