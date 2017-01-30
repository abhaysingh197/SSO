//
//  WelcomeController.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/25/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class WelcomeController: BaseViewController {
    
    var userName = ""

    @IBAction func profileAction(_ sender: Any) {
        performSegue(withIdentifier: "profileAccount", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileAccount" {
            _ = segue.destination as! ProfileViewController
            //destinationVC.userName = user
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "WelCome, "+userName
    }

    @IBOutlet weak var welcomeLabel: UILabel!


}
