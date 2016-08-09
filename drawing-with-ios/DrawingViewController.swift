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
    var red : CGFloat = 0
    var green : CGFloat = 0
    var blue : CGFloat = 0
    var lineWidth : CGFloat = 15
    
    
    // MARK: View Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DrawingViewController.appBecameActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        blueButtonTapped(UIButton())
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
            
            drawBetweenPoints(self.lastPoint, secondPoint: point)
            self.lastPoint = point
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(imageView)
            print(point)
            
            drawBetweenPoints(self.lastPoint, secondPoint: point)
        }
        print("End")
        self.buttonStackView.hidden = false
    }
    
    func drawBetweenPoints(firstPoint: CGPoint, secondPoint : CGPoint) {
        //Draw Context
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        self.imageView.image?.drawInRect(CGRect(x:0,y:0,width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
        CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y)
        
        // Stroke Color
        CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, 1.0)
        
        // Line Size - Round/Square
        CGContextSetLineCap(context, .Round)
        
        // Line Width
        CGContextSetLineWidth(context, self.lineWidth)
        CGContextStrokePath(context)
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
    }
    
    // MARK: Notification Center - Helper Function
    func appBecameActive() {
        self.buttonStackView.hidden = false
    }
    
    // MARK: Erase Canvas Function
    
    func clear() {
        self.imageView.image = nil
    }
    
    // MARK: Color Button Functions
    @IBAction func blueButtonTapped(sender: AnyObject) {
        print("Blue")
        self.red = 60 / 255
        self.green = 112 / 255
        self.blue = 226 / 255
    }
    @IBAction func greenButtonTapped(sender: AnyObject) {
        print("Green")
        self.red = 54 / 255
        self.green = 233 / 255
        self.blue = 119 / 255
    }
    
    @IBAction func redButtonTapped(sender: AnyObject) {
        print("Red")
        self.red = 226 / 255
        self.green = 58 / 255
        self.blue = 62 / 255
    }
    @IBAction func yellowButtonTapped(sender: AnyObject) {
        self.red = 248 / 255
        self.green = 213 / 255
        self.blue = 55 / 255
        print("Yellow")
    }
    @IBAction func randomButtonTapped(sender: AnyObject) {
        print("Random")
        self.red = CGFloat(arc4random_uniform(255)) / 255
        self.green = CGFloat(arc4random_uniform(255)) / 255
        self.blue = CGFloat(arc4random_uniform(255)) / 255
        
    }
    
}


