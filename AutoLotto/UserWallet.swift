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
    
    class var money:Float {
        get {
            return sharedInstance.money
        }
    }
    
    class func addMoney(amount: Float) {
        sharedInstance.money += amount
    }
    
    class func removeMoney(amount: Float) {
        sharedInstance.money -= amount
        if money < 0 {
            sharedInstance.money = 0
        }
    }
    
    class func getChange() -> String {
        return String(format: "%02.0f", (sharedInstance.money - floorf(sharedInstance.money))  * 100.0)
    }
    class func getDollars() -> String {
        return String(format: "%.0f", sharedInstance.money)
    }
    
    class func getUSDFormat() -> String {
        return String(format: "$%.2f", sharedInstance.money)
    }
}