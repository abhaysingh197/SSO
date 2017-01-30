//
//  BaseViewController.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/27/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class BaseViewController:UIViewController {
    
    
    let keychainManager = SSOManager()
    
    
    var accountList :[String:Int] {
        get{
            return keychainManager.getUserListFromKeychain()
        }
    }
    
    var accountEnableList : [String] {
        get{
            var enableList:[String] = []
            for (keys, value) in accountList {
                if value == 1 {
                    enableList.append(keys)
                }
            }
            return enableList
        }
    }
    
    
}
