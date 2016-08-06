//
//  SettingsViewController.swift
//  drawing-with-ios
//
//  Created by Ron Ramirez on 8/6/16.
//  Copyright © 2016 Mochi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    weak var drawVC : DrawingViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }
    @IBAction func clearCanvas(sender: AnyObject) {
        self.drawVC?.clear()
        self.navigationController?.popViewControllerAnimated(true)
        
    }

}