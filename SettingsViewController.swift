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
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Set slider value based on user preference
        if let vc = self.drawVC {
            self.slider.value = Float(vc.lineWidth)
        }
    }
    @IBAction func clearCanvas(sender: AnyObject) {
        self.drawVC?.clear()
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    @IBAction func shareButtonTapped(sender: AnyObject) {
        if let image = self.drawVC?.imageView.image {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    @IBAction func brushSizeSlider(sender: UISlider) {
        print(CGFloat(sender.value))
        self.drawVC?.lineWidth = CGFloat(sender.value)
   
        
        
    }
    
}