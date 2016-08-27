//
//  KenoButtonGridView.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit


@IBDesignable class KenoButtonGridView: UIView {
    
    @IBInspectable var gridStartIndex:Int = 0 {
        didSet {
            tagButtons()
        }
    }
    var buttons:[KenoNumberButton] = []
    var gridDivisionSize:CGSize = CGSize(width: 40.0, height: 40.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButtonGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createButtonGrid()
    }
    
    override func prepareForInterfaceBuilder() {
        refreshButtons()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        refreshButtons()
    }
    
    func refreshButtons() {
        gridDivisionSize = CGSize(width: self.frame.size.width / 10.0, height: self.frame.size.height / 4.0)
        tagButtons()
        positionButtons()
    }
    func positionButtons() {
        for btn in buttons {
            positionButton(btn)
        }
    }
    
    func tagButtons() {
        for i in 0..<buttons.count {
            let btn = buttons[i]
            btn.tag = gridStartIndex + i
            btn.title = "\(btn.tag + 1)"
        }
    }
    func clearButtons() {
        for btn in buttons {
            btn.removeFromSuperview()
        }
        buttons.removeAll()
    }
    
    func createButtonGrid() {
        gridDivisionSize = CGSize(width: self.frame.size.width / 10.0, height: self.frame.size.height / 4.0)
        clearButtons()
        
        for i in 0..<4 {
            for j in 0..<10 {
                addButton(i, j)
            }
        }
    }
    
    func addButton(i: Int, _ j: Int) {
        let button = KenoNumberButton()
        buttons.append(button)
        addSubview(button)
    }
    
    func positionButton(button:KenoNumberButton) {
        let n = button.tag - gridStartIndex
        let i = n/10
        let j = n-i*10
        let ny = CGFloat(i)
        let nx = CGFloat(j)
        button.frame =  CGRect(origin: CGPoint(x: nx * gridDivisionSize.width, y: ny*gridDivisionSize.height), size: gridDivisionSize).perfectSquareInRect()
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
