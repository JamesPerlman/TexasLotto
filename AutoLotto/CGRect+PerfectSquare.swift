//
//  CGRect+PerfectSquare.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import CoreGraphics

extension CGRect {
    func perfectSquareInRect() -> CGRect {
        var p = CGPoint()
        var s:CGFloat
        if self.size.width > self.size.height {
            s = self.size.height
            p.x = self.origin.x + 0.5 * (self.size.width - s)
            p.y = self.origin.y
        } else {
            s = self.size.width
            p.x = self.origin.x
            p.y = self.origin.y + 0.5 * (self.size.height - s)
        }
        
        return CGRect(origin: p, size: CGSizeMake(s, s))
    }
}