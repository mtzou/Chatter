//
//  ViewController.swift
//  chatter
//
//  Created by baLLad & Kronk on 10/14/17.
//  Copyright © 2017 Wand Inc. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var customField: UITextField!
    
    // if user decides to input custom field, transition to second view once "Done" is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        globals.msg = customField.text!
        print("set global msg to " + globals.msg)
        self.presentFromRight(self.getViewController(name: "SecondViewController"))
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customField.returnKeyType = .done
        self.customField.delegate = self;
        
        // populate with msg if already set
        customField.text = globals.msg
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let button = MessageButton(value: "running")
        
        button.addTarget(self, action: #selector(ViewController.buttonPressed(sender:)) , for: .touchUpInside)

//        button.addTarget(self, action: "buttonClicked:", for: .touchUpInside)
//        button.addTarget(self, action: Selector("buttonClicked:"), for: .touchUpInside)
        // let button = CustomButton() // also works
        button.setTitle("Run...", for: .normal)
        
        // auto layout
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

    @objc func buttonPressed(sender: MessageButton!) {
        globals.msg = sender.myValue
        print("set global msg to " + globals.msg)
        self.presentFromRight(self.getViewController(name: "SecondViewController"))
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            self.presentFromLeft(self.getViewController(name: "ThirdViewController"))
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            self.presentFromRight(self.getViewController(name: "SecondViewController"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController {
    
    
    // swipe left, right
    @objc func getViewController(name : String) -> UIViewController {
        return self.storyboard!.instantiateViewController(withIdentifier: name)
    }
    
    func presentFromRight(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    func presentFromLeft(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }

}
