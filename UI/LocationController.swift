//
//  ViewController.swift
//  UI
//
//  Created by kien on 11/25/16.
//  Copyright © 2016 kien. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var unhiddenpassword: UIButton!
    
    @IBOutlet weak var uncheckbox: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: FIRDatabaseReference! = nil
    var utenteRef: FIRDatabaseReference! = nil
    
    var checkbox = UIImage(named: "check")
    var ucheckbox = UIImage(named: "uncheck")
    
    var hide = UIImage(named: "hide")
    var hidden = UIImage(named: "hidden")
    
    var isboxclicked: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isboxclicked = false
        
        self.hideKeyboardWhenTappedAround()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func wathertrans(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "weather", sender: nil)
    }
    @IBAction func clickhidden(_ sender: AnyObject) {
        if isboxclicked == true {
            isboxclicked = false
        } else {
            isboxclicked = true
        }
        
        if isboxclicked == true
        {
            unhiddenpassword.setImage(hide, for: UIControlState.normal)
        } else {
            unhiddenpassword.setImage(hidden, for: UIControlState.normal)
        }
        
    }
    
    @IBAction func clickbox(_ sender: AnyObject) {
        
        if isboxclicked == true {
            isboxclicked = false
        } else {
            isboxclicked = true
        }
        
        if isboxclicked == true
        {
            uncheckbox.setImage(checkbox, for: UIControlState.normal)
        } else {
            uncheckbox.setImage(ucheckbox, for: UIControlState.normal)
        }
    }
    
    @IBAction func ForgotAction(_ sender: AnyObject) {
        
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.login_failed()
                return
            }
            self.performSegue(withIdentifier: "seque", sender: nil)
            self.login_successful()
        })

    }
        
    func login_successful()
    {
        
    }
    
    func login_failed()
    {
        
      
    }
    
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }

}

// Extension

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

