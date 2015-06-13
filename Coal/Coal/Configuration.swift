//
//  Configuration.swift
//  Coal
//
//  Created by Christopher Getschmann on 07.06.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

class Configuration: NSObject {
    
    static let statusBarColorUndefined      = UIColor(red: 0.5,     green: 0.5,     blue: 0.5,      alpha: 1)
    static let statusBarColorOk             = UIColor(red: 141/255, green: 189/255, blue: 12/255,   alpha: 1)
    static let statusBarColorError          = UIColor(red: 235/255, green: 84/255,  blue: 19/255,   alpha: 1)
    static let statusBarColorUnreachable    = UIColor(red: 0.1,     green: 0.1,     blue: 0.1,      alpha: 1)
    
    static let silentColor: UIColor         = UIColor(red: 108/255, green: 143/255, blue: 196/255,  alpha: 1)
    static let highColor: UIColor           = UIColor(red: 235/255, green: 84/255,  blue: 19/255,   alpha: 1)

    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let server_address_key = "SERVER_ADDRESS"
    
    var server_address: String? = ""
    
    override init() {
        self.server_address = defaults.stringForKey(server_address_key)
    }
    
    func save() -> Void {
        defaults.setObject(server_address, forKey: server_address_key)
    }
    
}
