//
//  RewardsInfo.swift
//  App
//
//  Created by austin bassett on 2018-10-28.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import Foundation
import UIKit

//-----------Public Variables-----------------
var rewardsDesc = ["$20 gift card to Energy Engineering juice bar. Vaild at any location.", "Free servicing for your bike at Design Bike shop.", "$10 Gift card for Walmart.", "A one month bus pass.", "2 can dine for the price of one at ADLMR inc.", "Enjoy a free medium hot beverage at Caffine Overload.", "Enjoy a free medium ice cold beverage at Engineering Icicles."]

var rewardCost = ["20", "20", "30", "250", "200", "70", "70"]





class infoRewards {

    class setUp{
        
        let title: String
        let imageCost: String
        let labelCost: String
        
        init(title: String, imageCost: String, labelCost: String){
            
            
                self.title = title
                self.imageCost = imageCost
                self.labelCost = labelCost
            
            }//init
    }//setUp
    let picTest = [ setUp(title:"$20 Juice Gift Card", imageCost: "Leave.png", labelCost: "20"),
                    setUp(title: "Free Bike Maintanice", imageCost: "Leave.png", labelCost: "20"),
                    setUp(title: "$10 Gift card to Walmart", imageCost: "Leave.png", labelCost: "30"),
                    setUp(title: "Month Bus Pass", imageCost: "Leave.png", labelCost: "250"),
                    setUp(title: "2 for 1 Dinner deal", imageCost: "Leave.png", labelCost: "200"),
                    setUp(title: "Medium Hot Beverage", imageCost: "Leave.png", labelCost: "70"),
                    setUp(title:"Medium Cold Beverage", imageCost: "Leave.png", labelCost: "70")]
    
    
    
    
}//inforRewards

