//
//  Rewards.swift
//  App
//
//  Created by austin bassett on 2018-10-24.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit

//-----------------Public Variables----------------------

 var myIndex = 0



class Rewards: UIViewController {
    
    //-------------Outlets----------------------

    @IBOutlet weak var homeBtnPressed: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pointsCounter: UILabel!
    
    //-------------Variables--------------------
    
    
    let infoReward = infoRewards()
    let defaults = UserDefaults.standard
    
    //var pointTxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointsCounter.text = defaults.object(forKey: "CurrentValue") as? String
        
        
        view.addSubview(homeBtnPressed)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }//viewDidLoad
    
    
    //------------- Buttons -----------------------
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        let button = homeBtnPressed
        button?.addTarget(self, action: #selector(goBackHome), for: .touchUpInside)
    }
    
    @objc func goBackHome(){
        let goHome = ViewController()
        present(goHome, animated: true, completion: nil)
        
    }//goBackHome

}//Rewards


//------------- Cell Setup --------------------

extension Rewards: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoReward.picTest.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageM = infoReward.picTest[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsC") as! RewardsCells
        let image2 = UIImage(named: imageM.imageCost)
        
        
        cell.labelReward.text = imageM.title
        cell.labelCost.text = imageM.labelCost
        cell.imageCost.image = image2
        
        return cell
        
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "RewardCollect", sender: self)
    }
    
    
    
}//extension Rewards
