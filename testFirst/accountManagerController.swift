//
//  accountManagerController.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/27/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

protocol changeInAccount {
    func removeAccountAction(userName:String) -> Bool
}


class accountRemoveCell: UITableViewCell {
    
    @IBOutlet weak var userNameRemoveLabel: UILabel!
    
    @IBAction func removeAccountAction(_ sender: Any) {
    }
    
    //@IBOutlet weak var userNameLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

class accountManagerController: BaseViewController, UITableViewDelegate, UITableViewDataSource, enableInAccount {

    
    var cancelButtonClicked = false
    var comingFromProfile = false
    
    
    @IBOutlet weak var editLabel: UIButton!
    @IBOutlet weak var cancelLabel: UIButton!
    @IBOutlet weak var doneLabel: UIButton!
    
    @IBOutlet weak var enableAccount: UITableView!
    @IBOutlet weak var removeAccount: UITableView!
    
    
    
    
    @IBAction func editAction(_ sender: Any) { //switch to removal account table cell
        removeAccount.isHidden = false
        enableAccount.isHidden = true
        editLabel.isHidden = true
        doneLabel.isHidden = false
        cancelLabel.isHidden = true
        self.view.layoutIfNeeded()
    }

    @IBAction func cancelAction(_ sender: Any) {
        cancelButtonClicked = true
        if !comingFromProfile {
            performSegue(withIdentifier: "loginCell", sender: self)
        }else {
            performSegue(withIdentifier: "exitToProfile", sender: self)
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        removeAccount.isHidden = true
        enableAccount.isHidden = false
        doneLabel.isHidden = true
        editLabel.isHidden = false
        cancelLabel.isHidden = false
        self.view.layoutIfNeeded()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("total number of user in the list : \(accountList)")
        var count:Int?
        if tableView == self.enableAccount {
            count = accountList.count+1
        }
        if tableView == self.removeAccount {
            count =  accountList.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == self.enableAccount {
            if indexPath.row == (accountList.count) {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "addAccount")
                cell.textLabel?.text = "Add a account"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userNameCell") as! accountEnableCell
                 let accountNametext = [String](accountList.keys)[indexPath.row]
                for (key, value) in accountList {
                    cell.userNameLabel.text = accountNametext
                    if key == accountNametext {
                        if value == 1 {
                            cell.switchLabel.isOn = true
                        } else {
                            cell.switchLabel.isOn = false
                        }
                    }
                }
                cell.delegate = self
                return cell
            }
        } else {
            if tableView == self.removeAccount {
                let cell = tableView.dequeueReusableCell(withIdentifier: "accountRemove") as! accountRemoveCell
                cell.userNameRemoveLabel.text = [String](accountList.keys)[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "accountRemove") as! accountRemoveCell
                cell.userNameRemoveLabel.text = [String](accountList.keys)[indexPath.row]
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //add a account goes to login Cell
        if tableView == self.enableAccount {
            if indexPath.row == (accountList.count) {
                performSegue(withIdentifier: "loginCell", sender: self)
            }
        }
        
    }
    
    func enableAccountAction(cell: accountEnableCell) {
        let usernameEnable = cell.userNameLabel.text!
        let enableAccount = cell.switchLabel.isOn
        if keychainManager.enableUserToKeychain(userName: usernameEnable, enable: enableAccount) {
            print("userName : \(usernameEnable) and enable status is \(enableAccount)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeAccount.isHidden = true
        enableAccount.isHidden = false
        doneLabel.isHidden = true
    }

}
