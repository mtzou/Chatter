//
//  MessageButton.swift
//  chatter
//
//  Created by Richard Chen on 10/15/17.
//  Copyright © 2017 Richard Chen. All rights reserved.
//

import Foundation
import UIKit

class MessageButton: UIButton {
    
    var myValue: String
    var selectedField: UILabel!
    var nextVC : SecondViewController!
    
//    override func doSomething() {
//        print("fuq")
//    }


    required init(value: String = "") {
        // set myValue before super.init is called
        self.myValue = value
        super.init(frame: .zero)
//        self.addTarget(self, action: #selector(ViewController.buttonPressed(sender:)) , for: .touchUpInside)

        // set other operations after super.init, if required
        backgroundColor = .blue
        self.showsTouchWhenHighlighted = true
//        self.sendActions(for: .touchUpInside)
//        self.sendActions(for: .touchDown)
        // todo ; button presses move to next screen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
