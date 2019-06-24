//
//  Profile.swift
//  App
//
//  Created by austin bassett on 2018-10-24.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit
import os.log
import FirebaseAuth
import Charts

class Profile: UIViewController {
    
    
    
    //------------Variables--------------------------
    
    var janEntry = PieChartDataEntry(value: 522)
    var febEntry = PieChartDataEntry(value: 500)
    var marEntry = PieChartDataEntry(value: 500)
    var aprEntry = PieChartDataEntry(value: 500)
    var mayEntry = PieChartDataEntry(value: 500)
    var junEntry = PieChartDataEntry(value: 520)
    var julEntry = PieChartDataEntry(value: 500)
    var augEntry = PieChartDataEntry(value: 999)
    var sepEntry = PieChartDataEntry(value: 550)
    var octEntry = PieChartDataEntry(value: 750)
    var novEntry = PieChartDataEntry(value: 825)
    var decEntry = PieChartDataEntry(value: 925)
    
    var numberOfMonth = [PieChartDataEntry]()
    

    
    //------------Outlets----------------------------

    @IBOutlet weak var lineChartView: PieChartView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nameTxtBox: UITextField!
    @IBOutlet weak var ageTxtBox: UITextField!
    @IBOutlet weak var countryTxtBox: UITextField!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    //------------View Data--------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let legend = lineChartView.legend
        
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        
    
        
        profileInfo()
        
        lineChartView.centerText = "Monthly Average CO2"
        
        legend.font = UIFont(name: "Times New Roman", size: 12.0)!

        
        chartLabels()
        
        numberOfMonth = [janEntry,
                         febEntry,
                         marEntry,
                         aprEntry,
                         mayEntry,
                         junEntry,
                         julEntry,
                         augEntry,
                         sepEntry,
                         octEntry,
                         novEntry,
                         decEntry]
        
        updateChartData()

        view.addSubview(homeBtn)

        
    }//viewDidLoad
    
    
    //-----------------Importing Info From Settings-------------------------------

    func profileInfo(){
        
        nameLbl.text = UserDefaults.standard.object(forKey: "Name") as? String
        ageLbl.text = UserDefaults.standard.object(forKey: "Age") as? String
        countryLbl.text = UserDefaults.standard.object(forKey: "Country") as? String
        heightLbl.text = UserDefaults.standard.object(forKey: "Height") as? String
        genderLbl.text = UserDefaults.standard.object(forKey: "Gender") as? String
        userNameLbl.text = UserDefaults.standard.object(forKey: "Username") as? String
        
    }//profileInfo
    
    //--------------------------Chart--------------------------------------------
    
    
    func updateChartData(){
        
        let chartDataSet = PieChartDataSet(values: numberOfMonth, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = [UIColor(displayP3Red: 1.0, green: 0.3, blue: 0.1, alpha: 1.0),
                      UIColor(displayP3Red: 0.4, green: 0.4, blue: 0.32, alpha: 1.0),
                      UIColor(displayP3Red: 0.2, green: 0.3, blue: 0.25, alpha: 1.0),
                      UIColor(displayP3Red: 0.3, green: 0.25, blue: 1.0, alpha: 1.0),
                      UIColor(displayP3Red: 0.9, green: 0.01, blue: 0.9, alpha: 1.0),
                      UIColor(displayP3Red: 0.3, green: 0.0, blue: 0.12, alpha: 1.0),
                      UIColor(displayP3Red: 0.0, green: 0.25, blue: 1.0, alpha: 1.0),
                      UIColor(displayP3Red: 0.3, green: 0.0, blue: 1.0, alpha: 1.0),
                      UIColor(displayP3Red: 0.3, green: 0.25, blue: 0.0, alpha: 1.0),
                      UIColor(displayP3Red: 0.39, green: 0.2, blue: 0.2, alpha: 1.0),
                      UIColor(displayP3Red: 0.74, green: 0.55, blue: 0.62, alpha: 1.0),
                      UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)]
        
        chartDataSet.colors = colors
        
        lineChartView.data = chartData
        
    }//updateChartData
    
        
   

    func chartLabels(){
        
        janEntry.label = "Jan"
        febEntry.label = "Feb"
        marEntry.label = "Mar"
        aprEntry.label = "Apr"
        mayEntry.label = "May"
        junEntry.label = "Jun"
        julEntry.label = "Jul"
        augEntry.label = "Aug"
        sepEntry.label = "Sep"
        octEntry.label = "Oct"
        novEntry.label = "Nov"
        decEntry.label = "Dec"
        
        
        
    }//chartLabels
    
    

 
    
    //--------------Buttons--------------------------------------------------------
    
    @IBAction func homeBtnPessed(_ sender: Any) {
        let button = homeBtn
        button?.addTarget(self, action: #selector(goBackHome), for: .touchUpInside)
        
    }//homeBtnPressed
    
    @objc func goBackHome(){
        let goHome = ViewController()
        present(goHome, animated: true, completion: nil)
        
    }//goBackHome
    
    
    //-------------Text---------------------------
    
    //Storing
    
    @IBAction func nameText(_ sender: Any) {
    }
    
    @IBAction func ageText(_ sender: Any) {
    }
    
    @IBAction func countryText(_ sender: Any) {
    }
    
    
    //----------Logout------------------
    

    
    @IBAction func logoutTapped(_ sender: Any) {
        
        do{
            
            
            try Auth.auth().signOut()
        
            self.logoutPass()
            
        }catch{
            
            print("There was a problem logging out")
            
        }
        
    }//logoutTapped
    
    func logoutPass(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logoutGood:Login = storyboard.instantiateViewController(withIdentifier: "Login") as! Login
        
        self.present(logoutGood, animated: true, completion: nil)
        
        
    }
    
    
}//Profile
