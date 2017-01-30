//
//  ViewController.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/25/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var theTextFieldUsername: UITextField!
    @IBOutlet weak var theTextFieldPassword: UITextField!
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet weak var loginCellView: UIView!
    @IBOutlet weak var manageAccountLabel: UILabel!
    @IBOutlet weak var loggedInAsLabel: UILabel!
    
    var user = ""
    
    var someDict = ["abhay" : "sears", "vinod" : "kmart", "hue" : "shopyourway"]

    @IBAction func theVerifyMethod(_ sender: Any) {
        for (name , pass) in someDict {
            if theTextFieldUsername.text == name && theTextFieldPassword.text == pass {
                user = name
                theTextFieldUsername.resignFirstResponder()
                theTextFieldPassword.resignFirstResponder()
                if keychainManager.addUserToKeychain(userName: name, password: pass) {
                    print("successfully added to keychain")
                } else {
                    print("error occured while adding to keychain")
                }
                performSegue(withIdentifier: "welcome", sender: self)
            }
            else {
                theLabel.text = "Credential were not correct"
                theLabel.textColor = UIColor.red
                theTextFieldUsername.resignFirstResponder()
                theTextFieldPassword.resignFirstResponder()
            }
        }
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return accountEnableList.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if indexPath.row == (accountEnableList.count) {
             cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "manager")
            cell?.textLabel?.text = "Manage Account"
        } else {
             cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell?.textLabel?.text = accountEnableList[indexPath.row]
        }
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (accountList.count) {
            performSegue(withIdentifier: "accountManager", sender: self)
        } else {
            let passwd = keychainManager.getUserPassFromKeychain(userName: [String](accountList.keys)[indexPath.row])
            if someDict[accountEnableList[indexPath.row]] == passwd {
                performSegue(withIdentifier: "welcome", sender: self)
            } else {
                print("password is not matching")
            }
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcome" {
            let destinationVC = segue.destination as! WelcomeController
            destinationVC.userName = user
        }
        if segue.identifier == "accountManager" {
            _ = segue.destination as! accountManagerController
        }
    }
    
    
    @IBAction func unwindfromAccountManagerToWelcomeLogin(_ sender: UIStoryboardSegue) {
        if let sourceController = sender.source as? accountManagerController {
            if !sourceController.cancelButtonClicked {
                accountTableView.isHidden = true
                loggedInAsLabel.isHidden = true
                loginCellView.isHidden = false
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !accountList.isEmpty {
            loginCellView.isHidden = true
            loggedInAsLabel.isHidden = false
            accountTableView.isHidden = false
        }else {
            accountTableView.isHidden = true
            loggedInAsLabel.isHidden = true
            loginCellView.isHidden = false
        }
    }


}

