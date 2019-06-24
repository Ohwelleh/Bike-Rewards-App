//
//  Information.swift
//  App
//
//  Created by austin bassett on 2018-10-24.
//  Copyright © 2018 Ohwelleh. All rights reserved.
//

import UIKit

class Information: UIViewController {

    @IBOutlet weak var homeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(homeBtn)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        let button = homeBtn
        button?.addTarget(self, action: #selector(goBackHome), for: .touchUpInside)
    }
    
    @objc func goBackHome(){
        let goHome = ViewController()
        present(goHome, animated: true, completion: nil)
    }

}
