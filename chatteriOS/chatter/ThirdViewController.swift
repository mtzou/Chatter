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
import Contacts


class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var customNumberField: UITextField!
    @IBOutlet weak var ContactTableView: UITableView!
    
    // send to custom input number
    @IBAction func sendGlobals(_ sender: Any) {
        self.sendMessageRPC(to: globals.to, msg: globals.msg, delay: Double(globals.duration))
    }
    
    // favorite contact presets
    @IBAction func sendRichard(_ sender: Any) {
        self.sendMessageRPC(to: "16468725907", msg: globals.msg, delay: Double(globals.duration))
    }
    @IBAction func sendMichelle(_ sender: Any) {
        self.sendMessageRPC(to: "13215446737", msg: globals.msg, delay: Double(globals.duration))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        globals.to = customNumberField.text!
        print("set global to to " + globals.to)
        return false
    }
    
    func sendMessageRPC(to : String, msg : String, delay : Double) {
        let parameters : [String : Any] = [
            "to": to,
            "msg": msg,
            "delay" : delay,
            ]
        let request = Alamofire.request("http://ec2-52-87-241-210.compute-1.amazonaws.com:3000/send", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        request.responseString { response in
            print(response)
        }
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNumberField.returnKeyType = .done
        self.customNumberField.delegate = self;

        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        addressBook()
    }
    
    // contact stuff
    func presentSettingsActionSheet() {
        let alert = UIAlertController(title: "Permission to Contacts", message: "This app needs access to contacts in order to ...", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func addressBook() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .denied || status == .restricted {
            presentSettingsActionSheet()
            return
        }
        
        // open it
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                DispatchQueue.main.async {
                    self.presentSettingsActionSheet()
                }
                return
            }
            
            // get the contacts
            
            var contacts = [CNContact]()
            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as NSString, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    contacts.append(contact)
                }
            } catch {
                print(error)
            }
            
            // do something with the contacts array (e.g. print the names)
            
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            for contact in contacts {
                print(formatter.string(from: contact) ?? "???")
            }
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            let secondVC = self.storyboard!.instantiateViewController(withIdentifier: "SecondViewController")
            self.presentFromLeft(secondVC)
//            self.present(secondVC, animated: true, completion: nil)

            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            let firstVC = self.storyboard!.instantiateViewController(withIdentifier: "FirstViewController")
            self.presentFromRight(firstVC)

//            self.present(firstVC, animated: true, completion: nil)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



