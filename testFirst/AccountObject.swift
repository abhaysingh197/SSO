//
//  AccountObject.swift
//  testFirst
//
//  Created by Singh, Abhay on 1/26/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation

class AccountObject{
    fileprivate(set) var firstName: String?
    fileprivate(set) var lastName: String?
    fileprivate(set) var userName: String?

    
    init(firstName: String, lastName:String, userName:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
    }
}
