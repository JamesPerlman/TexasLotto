//
//  KenoViewController.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

let KenoWinbackPercent:Float = 0.50

class KenoViewController: UIViewController {
    @IBOutlet weak var bottomButtonSpace:NSLayoutConstraint!
    @IBOutlet weak var bottomButton:UIButton!
    @IBOutlet weak var clearButton:UIButton!
    @IBOutlet weak var bottomLabel:UILabel!
    @IBOutlet weak var betLabel:UILabel!
    @IBOutlet weak var slider:JPStylizedSlider!
    @IBOutlet weak var gridView1:KenoButtonGridView!
    @IBOutlet weak var gridView2:KenoButtonGridView!
    
    var allButtons = [KenoNumberButton]()
    var selectedButtons = [KenoNumberButton]()
    var betAmount:Float = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allButtons.removeAll()
        allButtons.appendContentsOf(gridView1.buttons)
        allButtons.appendContentsOf(gridView2.buttons)
        connectButtons()
        
        bottomButtonSpace.constant = -60
        view.layoutIfNeeded()
        
    }
    
    func connectButtons() {
        for btn in allButtons {
            btn.addTarget(self, action: #selector(didTouchButton(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func updateAmountLabel() {
        if UserWallet.money == 0 {
            
        } else {
            bottomLabel.text = "You have \(UserWallet.getUSDFormat()) left."
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
        
        // hide the play button if necessary
        if selectedButtons.count == 10 {
            showBottomButton()
        } else {
            hideBottomButton()
        }
    }
    func hideBottomButton() {
        if bottomButtonSpace.constant == 0 {
            UIView.animateWithDuration(0.3) { [weak self] in
                self?.bottomButtonSpace.constant = -60
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    func showBottomButton() {
        if bottomButtonSpace.constant == -60 {
            UIView.animateWithDuration(0.3) { [weak self] in
                self?.bottomButtonSpace.constant = 0
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func sliderDidChange(sender: JPStylizedSlider) {
        betAmount = sender.value
        betLabel.text = String(format: "$%.0f", betAmount)
    }
    
    @IBAction func playGame(sender: UIButton) {
        
        guard selectedButtons.count == 10 else { return }
        guard UserWallet.money > betAmount else {
            let betFormat = String(format: "$%.2f", betAmount)
            Alert(title: "Uh-oh!", message: "You can't make a \(betFormat) bet when you've only got \(UserWallet.getUSDFormat()) to spare! Head back to the main menu to add more cash.").showOkay()
            return
        }
        
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
        updateAmountLabel()
        hideBottomButton()
        clearButton.setTitle("Play Again", forState: .Normal)
        
    }
    
    func processPayment(bet bet:Float, payout: Float) {
        UserWallet.addMoney(payout)
        UserWallet.removeMoney(bet)
        let absNet = fabsf(payout-bet)
        let netFormat = String(format: "$%.2f", absNet)
        
        if payout > bet {
            Alert(title: "Congratulations!", message: "You won \(netFormat)! \(RandomMessageGenerator.messageWithTheme(TexasTalk.Congrats))").showOkay()
        } else if payout == bet {
            Alert(title: "Alright!", message: "Well, you broke even.  How's about one more?").showOkay()
        } else {
            Alert(title: "So sorry!", message: "You lost \(netFormat). \(RandomMessageGenerator.messageWithTheme(TexasTalk.Sorry)) Try again!").showOkay()
        }
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        selectedButtons.removeAll()
        resetButtons()
        setButtonsEnabled(true)
        clearButton.setTitle("Clear Board", forState: .Normal)
        bottomLabel.text = "Pick ten numbers to play."
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
