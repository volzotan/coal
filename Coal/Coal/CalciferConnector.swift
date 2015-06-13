//
//  CalciferConnector.swift
//  Coal
//
//  Created by Christopher Getschmann on 30.05.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum ConnectorStatus {
    case Undefined, Ok, Error, Unreachable
}

class CalciferConnector: NSObject {
    
    static let instance = CalciferConnector()

    let address = "http://localhost:5000/"
    let credential = NSURLCredential(user: "admin", password: "admin", persistence: .ForSession)
    
    var status: ConnectorStatus = ConnectorStatus.Undefined {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("RefreshUI", object: nil)
        }
    }
    
    func getAllMessages(callbackSuccess: (messages: [Message]) -> Void, callbackError: (status: Int?) -> Void) -> Void {
        var url = self.address + "messages/all"
        var parameters = Dictionary<String, AnyObject>()
        
        Alamofire.request(.GET, URLString: url, parameters: parameters)
            .authenticate(usingCredential: credential)
            .responseJSON { (req, res, json, error) in
                if (error != nil) {
                    //log.error("Error: \(error)")
                    
                    self.status = ConnectorStatus.Error
                    callbackError(status: res?.statusCode)
                }
                else {
                    //log.debug("Success: \(url)")
                    var json = JSON(json!)
                    
                    self.status = ConnectorStatus.Ok
                    
                    if (json.count > 0) {
                        callbackSuccess(messages: MessageUtil().parseJSON(json))
                    } else {
                        //log.debug("no messages received")
                        callbackSuccess(messages: [])
                    }
                }
        }
    }
    
    func setAllAsRead(ids: [String], callbackError: (status: Int?) -> Void) {
        var url = self.address + "messages/setasread"
        var parameters = Dictionary<String, AnyObject>()
        parameters["ids"] = ids
        
        Alamofire.request(.POST, URLString: url, parameters: parameters, encoding: .JSON)
            .authenticate(usingCredential: credential)
            .response { (req, res, data, error) in
                if (error != nil || res?.statusCode != 200) {
                    //log.error("Error: \(error)")
                    
                    self.status = ConnectorStatus.Error
                    callbackError(status: res?.statusCode)
                }
                else {
                    //log.debug("Success: \(url)")
                }
        }
    }
    
}
