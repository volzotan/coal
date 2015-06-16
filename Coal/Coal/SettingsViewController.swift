//
//  SettingsViewController.swift
//  Coal
//
//  Created by Christopher Getschmann on 07.06.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let configuration = Configuration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTextField.text = configuration.server_address
        usernameTextField.text = configuration.server_username
        passwordTextField.text = configuration.server_password
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        save()
    }
    
    func save() {
        configuration.server_address = addressTextField.text!
        configuration.server_username = usernameTextField.text!
        configuration.server_password = passwordTextField.text!
        configuration.save()
    }
    
}
