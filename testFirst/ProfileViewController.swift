//
//  ProfileViewController.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/29/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("total number of user in the list : \(accountList)")

        return accountList.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if indexPath.row == (accountList.count) {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "manageAccount")
                cell.textLabel?.text = "Manage Account"
                return cell
            } else {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "profileName")
                cell.textLabel?.text = [String](accountList.keys)[indexPath.row]
                return cell

            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //add a account goes to login Cell
            if indexPath.row == (accountList.count) {
                performSegue(withIdentifier: "accountManagerFromProfile", sender: self)
            }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "accountManagerFromProfile" {
            let destinationController = segue.destination as! accountManagerController
            destinationController.comingFromProfile = true
        }
    }
    
    @IBAction func unwindfromAccountManagerToProfile(_ sender: UIStoryboardSegue) {
        //self.view.backgroundColor! = UIColor.cyan
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
