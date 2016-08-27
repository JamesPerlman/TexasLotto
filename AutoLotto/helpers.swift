//
//  helpers.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import Foundation

func randomUniqueInts(count count:Int, low:Int = 0, high:Int) -> [Int] {
    precondition(high-low > count)
    var result = [Int]()
    var options = [Int](low...high)
    for _ in 0..<count {
        let idx = Int(arc4random_uniform(UInt32(options.count)))
        result.append(options[idx])
        options.removeAtIndex(idx)
    }
    return result
}