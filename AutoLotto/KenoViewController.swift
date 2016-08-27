//
//  KenoViewController.swift
//  AutoLotto
//
//  Created by James Perlman on 8/27/16.
//  Copyright © 2016 James Perlman. All rights reserved.
//

import UIKit

class KenoViewController: UIViewController {
    @IBOutlet var gridView1:KenoButtonGridView!
    @IBOutlet var gridView2:KenoButtonGridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectButtons(gridView1.buttons)
        connectButtons(gridView2.buttons)
    }
    
    func connectButtons(buttons: [KenoNumberButton]) {
        for btn in buttons {
            btn.addTarget(self, action: #selector(didTouchButton(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    @objc func didTouchButton(sender: KenoNumberButton) {
        sender.selected = !sender.selected
    }
}
