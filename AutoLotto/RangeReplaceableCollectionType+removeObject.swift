//
//  RangeReplaceableCollectionType+removeObject.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import Foundation

// thank you http://stackoverflow.com/a/30724543/892990

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}