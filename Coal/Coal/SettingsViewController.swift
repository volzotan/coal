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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("foo")
        self.view.endEditing(true)
        return false
    }
    
}
