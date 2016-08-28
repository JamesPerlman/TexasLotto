//
//  RandomMessageGenerator.swift
//  AutoLotto
//
//  Created by James Perlman on 8/28/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import Foundation

struct TexasTalk {
    static let Sorry = ["Don't get your panties in a wad.", "Even a blind squirrel finds an acorn once in a while.", "You can't get the oil unless you boil the hog."]
    static let Congrats = ["Yee-haw!", "You'll be ridin' the gravy train with biscuit wheels!"]
}

class RandomMessageGenerator {
    class func messageWithTheme(theme: [String]) -> String {
        return theme[Int(arc4random_uniform(UInt32(theme.count)))]
    }
}
