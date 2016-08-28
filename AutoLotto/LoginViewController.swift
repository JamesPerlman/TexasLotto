//
//  ViewController.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var username:UITextField!
    @IBOutlet weak var password:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UINavigationBar.appearance().barStyle = .Default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject?) {
        if username.text?.characters.count > 0 && password.text?.characters.count > 0 {
            UserWallet.reset()
            dismissKeyboard(nil)
            performSegueWithIdentifier("home", sender: self)
        } else {
            Alert(message: "Please enter a username and password.").showOkay()
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == username {
            password.becomeFirstResponder()
        } else {
            login(password)
        }
        return true
    }

}

