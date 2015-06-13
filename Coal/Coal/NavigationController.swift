//
//  NavigationController.swift
//  Coal
//
//  Created by Christopher Getschmann on 11.06.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit
//import XCGLogger

class NavigationController: UINavigationController {
    
    let calciferConnector = CalciferConnector.instance
    
    let statusBar = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.statusBar.frame = CGRectMake(0, 63, 320, 2)
        statusBar.backgroundColor = UIColor.greenColor()
        self.view.addSubview(statusBar)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshListener:", name:"RefreshUI", object: nil)
    }
    
    func refreshListener(notification: NSNotification){
        statusBar.setProgress(1.0, animated: false)
        
        switch (self.calciferConnector.status) {
        case ConnectorStatus.Undefined:
            statusBar.progressTintColor = Configuration.statusBarColorUndefined
        case ConnectorStatus.Ok:
            statusBar.progressTintColor = Configuration.statusBarColorOk
        case ConnectorStatus.Error:
            statusBar.progressTintColor = Configuration.statusBarColorError
        case ConnectorStatus.Unreachable:
            statusBar.progressTintColor = Configuration.statusBarColorUnreachable
        default:
            //log.error("illegal state Connector Status")
            break
        }
    }
}
