//
//  KenoNumberButton.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

class KenoNumberButton: UIButton {
    
    var title:String = "X" {
        didSet {
            self.setTitle(title, forState: .Normal)
            self.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            self.matched = false
        }
    }
    
    var matched:Bool = false {
        didSet {
            if matched {
                let bgImageName = matched ? "star" : "x"
                self.setBackgroundImage(UIImage(named: bgImageName), forState: .Selected)
                self.setBackgroundImage(UIImage(named: "hollow_star"), forState: .Normal)
            } else {
                self.setBackgroundImage(nil, forState: .Normal)
                self.setBackgroundImage(UIImage(named: "circle_\( arc4random_uniform(3) + 1 )"), forState: .Selected)
            }
        }
    }
}
