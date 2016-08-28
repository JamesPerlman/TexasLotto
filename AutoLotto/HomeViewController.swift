//
//  HomeViewController.swift
//  AutoLotto
//
//  Created by James Perlman on 8/28/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var dollarLabel:UILabel!
    @IBOutlet weak var centLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barStyle = .BlackTranslucent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshMoneyLabels()
    }
    
    @IBAction func addMoney(sender: UIButton?) {
        UserWallet.addMoney(50)
        Alert(title: "Success!", message: "We added fifty bucks to your account, on the house.  Go get 'em, cowboy.").showOkay()
        refreshMoneyLabels()
    }
    
    @IBAction func logOut(sender: UIButton?) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func refreshMoneyLabels() {
        dollarLabel.text = UserWallet.getDollars() + "."
        centLabel.text = UserWallet.getChange()
        view.layoutIfNeeded()
    }
}
