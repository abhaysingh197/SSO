//
//  SSOManager.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/26/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation
import UIKit


class SSOManager {
    
    //var accountNames : Set<String> = []
    
    var accountNames: [String:Int] = [:]
    
    static let KEY_ACCOUNTS = "searsAccount"

//     //static var account = [AccountObject]()
    let keychain = KeychainSwift()
    
    
    func addUserToKeychain(userName:String, password:String) -> Bool {
        //as soon user logs in add their username and password to keychain as seperate username and password
        //also, add user username to array which track how many users have been added
        var noErrAcct = false
        var noErrUsr  = false
        keychain.accessGroup = "DXK2N8YN8R.searshcAppGroup"
        accountNames = getUserListFromKeychain()
        //accountNames.insert(userName)
        accountNames[userName] = 1
        let accountDataArray = NSKeyedArchiver.archivedData(withRootObject: accountNames)
        if keychain.set(accountDataArray, forKey: SSOManager.KEY_ACCOUNTS) {
            noErrAcct = true
        }else {
            noErrAcct = false
        }
        
        if keychain.set(password, forKey: userName) {
            noErrUsr = true
        } else {
            noErrUsr = false
        }
        if noErrAcct && noErrUsr {
            return true
        }else {
            return false
        }
    }
    
    
    func enableUserToKeychain(userName:String, enable:Bool) -> Bool {
        //as soon user logs in add their username and password to keychain as seperate username and password
        //also, add user username to array which track how many users have been added
        var noErrAcct  = false
        keychain.accessGroup = "DXK2N8YN8R.searshcAppGroup"
        accountNames = getUserListFromKeychain()
        if enable {
            accountNames[userName] = 1
        } else {
            accountNames[userName] = 0
        }
        
        let accountDataArray = NSKeyedArchiver.archivedData(withRootObject: accountNames)
        if keychain.set(accountDataArray, forKey: SSOManager.KEY_ACCOUNTS) {
            noErrAcct = true
        }else {
            noErrAcct = false
        }
        return noErrAcct
    }
    
    func removeUserFromKeychain(userName:String) -> Bool{
        //as soon user remove username -  remove their username and password to keychain as seperate username and password key value
        //also, remove user username from array which track users emails
        var noErrAcct = false
        var noErrUsr  = false
        keychain.accessGroup = "DXK2N8YN8R.searshcAppGroup"
        accountNames = getUserListFromKeychain()
            if !accountNames.isEmpty {
                accountNames.removeValue(forKey: userName)
                let accountDataArray = NSKeyedArchiver.archivedData(withRootObject: accountNames)
                if keychain.set(accountDataArray, forKey: SSOManager.KEY_ACCOUNTS) {
                    noErrAcct = true
                }else {
                    noErrAcct = false
                }
                if keychain.delete(userName) {
                    noErrUsr = true
                } else {
                    noErrUsr = false
                }
            } else {
                return false
        }
        if noErrAcct && noErrUsr {
            return true
        }else {
            return false
        }
    }
    
    //Retrieves the set account value from the keychain that corresponds to the given key.
    
    //- parameter key: The key that is used to read the keychain item.
    //- returns: The set account value from the keychain. Returns empty if unable to read the item.
    
    func getUserListFromKeychain() -> [String:Int] {
        // get list of user has been added to this
        var accountsetArray : [String:Int] = [:]
        keychain.accessGroup = "DXK2N8YN8R.searshcAppGroup"
        if keychain.getData(SSOManager.KEY_ACCOUNTS)  != nil {
            let accountDataArray = keychain.getData(SSOManager.KEY_ACCOUNTS)!
            accountsetArray = NSKeyedUnarchiver.unarchiveObject(with: accountDataArray) as! [String:Int]
        }
        return accountsetArray
    }
    
    func getUserPassFromKeychain(userName:String) -> String{
        //as soon user remove username -  remove their username and password to keychain as seperate username and password key value
        //also, remove user username from array which track users emails
        var pass = ""
        keychain.accessGroup = "DXK2N8YN8R.searshcAppGroup"
        if (keychain.get(userName) != nil) {
            pass = keychain.get(userName)!
        }
        return pass
    }
}
