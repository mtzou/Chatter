//
//  ViewController.swift
//  chatter
//
//  Created by baLLad & Kronk on 10/14/17.
//  Copyright © 2017 Wand Inc. All rights reserved.
//

import UIKit
import Foundation


class SecondViewController: UIViewController {
    @IBOutlet weak var selectedTime: UIButton!
    @IBOutlet weak var sliderOut: UILabel!
    @IBOutlet weak var sliderIn: UISlider!


    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        selectedTime.addTarget(self, action: #selector(SecondViewController.buttonPressed(sender:)) , for: .touchUpInside)
    }
    
    @IBAction func sliderTouched(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        sliderOut.text = "\(currentValue)"
        globals.duration = currentValue * 60
//        self.presentFromRight(self.getViewController(name: "ThirdViewController"))
    }

    @objc func buttonPressed(sender: UIButton!) {
        self.presentFromRight(self.getViewController(name: "ThirdViewController"))
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            let firstVC = self.storyboard!.instantiateViewController(withIdentifier: "FirstViewController")
            self.presentFromLeft(firstVC)
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            let thirdVC = self.storyboard!.instantiateViewController(withIdentifier: "ThirdViewController")
            self.presentFromRight(thirdVC)
            globals.duration = Int(sliderIn.value) * 60
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




