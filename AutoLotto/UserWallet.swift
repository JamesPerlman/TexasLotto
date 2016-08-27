//
//  UserWallet.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import Foundation

class UserWallet {
    static let sharedInstance = UserWallet()
    private var money:Float = 500.0
    
    class func addMoney(amount: Float) {
        self.sharedInstance.money += amount
    }
    
    class func removeMoney(amount: Float) {
        self.sharedInstance.money -= amount
    }
    
    class func getChange() -> String {
        return String(format: "%.0f", self.sharedInstance.money * 100)
    }
    class func getDollars() -> String {
        return String(format: "%.0f", self.sharedInstance.money)
    }
    
    class func getUSDFormat() -> String {
        return String(format: "%.2f", self.sharedInstance.money)
    }
}