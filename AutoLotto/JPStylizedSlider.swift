//
//  JPStylizedSlider.swift
//  AutoLotto
//
//  Created by James Perlman on 8/28/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

@IBDesignable class JPStylizedSlider: UISlider {
    override func awakeFromNib() {
        self.stylize()
    }
    
    override func prepareForInterfaceBuilder() {
        self.stylize()
    }
    
    func stylize() {
        self.setThumbImage(UIImage(named:"brass_button"), forState: .Normal)
    }

}
