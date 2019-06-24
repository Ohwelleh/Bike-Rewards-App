//
//  ViewController.swift
//  App
//
//  Created by austin bassett on 2018-10-24.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit
import Firebase



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //---------Outlets------------------
    
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var rewardsBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var mediaFeed: UITableView!
    
    
    //--------Array----------------------
    
    var posts = [Post]()
   
    
    //---------Variables----------------
    
    let pointDefault = UserDefaults.standard
    let pointFieldConstant = "pointTxtField"
    let settingProfileInfo = SettingsScreen()
    let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
   
    
    var newPoints: String = "0"
    var oldPoints: String = "0"
    
  

   //----------View Data-----------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaFeed.register(cellNib, forCellReuseIdentifier: "postCell")
        
        pointFieldValue()
        
        view.addSubview(settingBtn)
        view.addSubview(profileBtn)
        view.addSubview(infoBtn)
        view.addSubview(rewardsBtn)
        
        updatePoints()
        
        
        mediaFeed.delegate = self
        mediaFeed.dataSource = self
        mediaFeed.tableFooterView = UIView()
        mediaFeed.reloadData()
        
        observePosts()
        
     
    }//viewDidLoad
    
    
    //---------------------Observe Posts---------------------------------------
    
    func observePosts(){
        let postsRef = Database.database().reference().child("posts")
        let queryRef = postsRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 20)
        
        queryRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Post]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    let author = dict["author"] as? [String: Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string: photoURL),
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                        
                    let userProfile = UserProfile(uid: uid, username: username, photoUrl: url)
                    let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp: timestamp)
                    
                    tempPosts.insert(post, at: 0)
                    
                }//childSnapshot
            }//for
            
            self.posts = tempPosts
            self.mediaFeed.reloadData()
            
        })
        
        
    }//observePosts
    
    
    //********* Buttons ***************************
    
    //--------Information Screen------------
    
    @IBAction func infoBtnPressed(_ sender: Any) {
        let button = infoBtn
        button?.addTarget(self, action: #selector(openInfoScreen), for: .touchUpInside)
    }
    
    @objc func openInfoScreen(){
        let infoScrn = Information()
        present(infoScrn, animated: true, completion: nil)
    }
    
    //--------Profile Screen------------
    
    @IBAction func profileBtnPressed(_ sender: Any) {
        let button = profileBtn
        button?.addTarget(self, action: #selector(openProfileScreen), for: .touchUpInside)
        
    }//profileBtnPressed
    
    @objc func openProfileScreen(){
        let profileScrn = Profile()
        present(profileScrn, animated: true, completion: nil)
        
    }//openProfileScreen
    
    //--------Rewards Screen---------
  
    @IBAction func rewardsBtnPressed(_ sender: Any) {
        let button = rewardsBtn
        button?.addTarget(self, action: #selector(opendRewardsScreen), for: .touchUpInside)
    }//rewardsBtnPressed
    
    @objc func opendRewardsScreen(){
        let rewardsScrn = Rewards()
        present(rewardsScrn, animated: true, completion: nil)
    }//openRewardsScreen
    
    //--------Setting Screen---------------------
    @IBAction func settingBtnPressed(_ sender: Any) {
        let button = settingBtn
        button?.addTarget(self, action: #selector (openSettingScreen), for: .touchUpInside)
    }//settingBtnPressed
    
    @objc func openSettingScreen() {
        let settingScrn = SettingsScreen()
        present(settingScrn, animated: true, completion: nil)
        
    }//openSettingScreen
    
    
    @IBAction func restPtsBtn(_ sender: Any) {
        
        restPoints()
        pointDefault.set(counterLabel.text, forKey:"CurrentValue")
        
        
    }//restPtsBtn
    
    
    
    //*********** Buttons End ******************
    
 
    
    
    //----------Update Points-------------------------------------
    
    func updatePoints(){
        
        if let updatePts = pointDefault.string(forKey: "CurrentValue"){
            
            counterLabel.text = updatePts
            
        }//updatePts
        
        
    }//updatePoints
    
    
    //----------Reset Points-----------------
    
    func restPoints(){
        
        let resetPts = "0"
        
        counterLabel.text = resetPts
        
        
    }//resetPoints
    
    
  
    
    //-----------Reward Point Tracker----------
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
        pointInputDialog()
        
    }//addBtnTapped
    
    //-----------Add New Points To Old Points------------
    
    func addPoint(new: Double, old: String) -> String{
        
        let oldPoints = Double(old)
        let scale = new / 5.0       //Scaling the points for 5KM
        let sum = ((scale + oldPoints!) * 100.0).rounded() / 100.0
        let total = String(format: "%.1f",sum)
        
        return total
        
    }//addPoints
    
    
    //-----------Pop-up Input------------------
    
    func pointInputDialog(){
        
        
        // Title of dialog and message
        let alertController = UIAlertController(title: "Distance", message: "Enter Kilometers", preferredStyle: .alert)
        // Confirm action taking inputs
    
        let confirmAction = UIAlertAction(title: "Enter", style: .default){ (_) in
            
            //getting Input
            let points = (alertController.textFields?[0].text)
            
            let currentPoints: String
            
            if let lastPoints = UserDefaults.standard.object(forKey: "CurrentValue"){
                
                currentPoints = lastPoints as! String
                
            }else{
                
                currentPoints = "0"
            }
            
            self.counterLabel.text = points!
            if let newPoints = Double(self.counterLabel.text!){
                
                self.counterLabel.text = self.addPoint(new: newPoints, old: currentPoints)
                
            }else{
                
                self.counterLabel.text = "0"
                
            }
            
            
            
            self.pointDefault.set(self.counterLabel.text, forKey: "CurrentValue")
            
            
        
            
        }//confirmAction
        //Cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (_) in }
        
        //adding text field to dialog box
        alertController.addTextField {
            (textField) in
            textField.placeholder = "Enter KM"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //present dialog box
        self.present(alertController, animated:  true, completion: nil)
        
    }//pointInputDialog
    
    //--------------------------Save Input-------------------------------------
    
    func pointFieldValue(){
        
        if let pointFieldsValue = pointDefault.string(forKey: "CurrentValue"){
            
            counterLabel.text = pointFieldsValue
            
        }
        
    }//pointFieldValue
    
    //--------------------------Table View--------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }//numberOfSections
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }//tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        cell.set(post: posts[indexPath.row])
        
        return cell
    }//cell
    
    
    
    
}//ViewController


