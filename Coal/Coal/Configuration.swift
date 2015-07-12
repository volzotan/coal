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
    
    private let server_address_key = "SERVER_ADDRESS"
    private let server_username_key = "SERVER_USERNAME"
    private let server_password_key = "SERVER_PASSWORD"
    
    var server_address: String = ""
    var server_username: String = ""
    var server_password: String = ""
    
    override init() {
        super.init()
        self.load()
    }
    
    func save() -> Void {        
        if server_address[server_address.endIndex.predecessor()] != "/" {
            server_address = server_address + "/"
        }
        
        defaults.setObject(server_address, forKey: server_address_key)
        defaults.setObject(server_username, forKey: server_username_key)
        defaults.setObject(server_password, forKey: server_password_key)
        
        CalciferConnector.instance.reloadConfigurationData()
    }
    
    func load() {
        if (defaults.stringForKey(server_address_key) != nil) {
            self.server_address = defaults.stringForKey(server_address_key)!
        }
        
        if (defaults.stringForKey(server_username_key) != nil) {
            self.server_username = defaults.stringForKey(server_username_key)!
        }
        
        if (defaults.stringForKey(server_password_key) != nil) {
            self.server_password = defaults.stringForKey(server_password_key)!
        }
    }
    
}
