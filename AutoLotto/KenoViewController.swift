//
//  KenoViewController.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

let KenoWinbackPercent:Float = 0.10

class KenoViewController: UIViewController {
    @IBOutlet var gridView1:KenoButtonGridView!
    @IBOutlet var gridView2:KenoButtonGridView!
    var allButtons = [KenoNumberButton]()
    var selectedButtons = [KenoNumberButton]()
    var betAmount:Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allButtons.removeAll()
        allButtons.appendContentsOf(gridView1.buttons)
        allButtons.appendContentsOf(gridView2.buttons)
        connectButtons()
    }
    
    func connectButtons() {
        for btn in allButtons {
            btn.addTarget(self, action: #selector(didTouchButton(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    @objc func didTouchButton(sender: KenoNumberButton) {
        if sender.selected { // button already selected.
            // deselect it, remove it from selected list
            sender.selected = false
            selectedButtons.removeObject(sender)
        } else {
            if selectedButtons.count < 10 {
                sender.selected = true
                selectedButtons.append(sender)
            }
        }
    }
    
    @IBAction func playGame(sender: AnyObject) {
        
        // unmatch all buttons
        for btn in allButtons {
            btn.matched = false
        }
        
        // match 15 numbers
        var payout:Float = 0
        let matches = randomUniqueInts(count: 15, high: 79)
        setButtonsEnabled(false)
        for match in matches {
            let btn = allButtons[match]
            btn.matched = true
            
            if btn.selected {
                payout += betAmount * KenoWinbackPercent
            }
        }
        
        processPayment(bet: betAmount, payout: payout)
        
    }
    
    func processPayment(bet bet:Float, payout: Float) {
        UserWallet.addMoney(payout)
        UserWallet.removeMoney(bet)
        let absNet = fabsf(payout-bet)
        let netFormat = String(format: "$%.2f", absNet)
        if (payout > bet) {
            Alert(title: "Congratulations!", message: "You won \(netFormat)!").showOkay()
        } else {
            Alert(title: "So sorry!", message: "You lost \(netFormat).  Better luck next time!").showOkay()
        }
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        selectedButtons.removeAll()
        resetButtons()
        setButtonsEnabled(true)
    }
    
    func setButtonsEnabled(enabled: Bool) {
        gridView1.userInteractionEnabled = enabled
        gridView2.userInteractionEnabled = enabled
    }
    
    func resetButtons() {
        for btn in allButtons {
            btn.selected = false
            btn.matched = false
        }
    }
}
