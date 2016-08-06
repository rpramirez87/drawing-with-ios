//
//  DrawingViewController.swift
//  drawing-with-ios
//
//  Created by Ron Ramirez on 8/6/16.
//  Copyright © 2016 Mochi. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DrawingViewController.appBecameActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.buttonStackView.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "drawingToSettingsSegue" {
            let settingsVC = segue.destinationViewController as! SettingsViewController
            settingsVC.drawVC = self
        }
    }
    
    // MARK: UITouch Functions
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.locationInView(imageView)
            self.lastPoint = point
        }
        
        print("Began")
        self.buttonStackView.hidden = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.buttonStackView.hidden = true
        if let touch = touches.first {
            let point = touch.locationInView(imageView)
            print(point)
            
            
            //Draw Context
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            
            let context = UIGraphicsGetCurrentContext()
            self.imageView.image?.drawInRect(CGRect(x:0,y:0,width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
            CGContextMoveToPoint(context, lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(context, point.x, point.y)
            CGContextStrokePath(context)
            
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            
            self.lastPoint = point
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(imageView)
            print(point)
        }
        print("End")
        self.buttonStackView.hidden = false
    }
    
    // MARK: Notification Center - Helper Function
    func appBecameActive() {
        self.buttonStackView.hidden = false
    }
    
    // MARK: Erase Canvas Function
    
    func clear() {
        self.imageView.image = nil
    }
}


