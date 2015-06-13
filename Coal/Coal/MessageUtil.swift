//
//  MessageUtil.swift
//  Coal
//
//  Created by Christopher Getschmann on 29.05.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

//import XCGLogger
import SwiftyJSON

class MessageUtil: NSObject {
    
    let dateFormat: String = "YYYY-MM-dd HH:mm:ss.SSSSSSZ"
    
    func parseJSON(json: JSON) -> [Message] {
        var returnList = [Message]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        for (index, jsonmsg): (String, JSON) in json {
            var mid: String = jsonmsg["message"]["mid"].stringValue
            var payload: String = jsonmsg["message"]["payload"].stringValue
            
            var priority: String = jsonmsg["message"]["priority"].stringValue
            var status: String = jsonmsg["message"]["status"].stringValue
            
            var add_time = dateFormatter.dateFromString(jsonmsg["add_time"].stringValue)
            var update_time = dateFormatter.dateFromString(jsonmsg["update_time"].stringValue)
            
            var sender: String = jsonmsg["sender"].stringValue
            
            var msg = Message(mid: mid, payload: payload)
            
            if (Message.Priority(rawValue: priority) != nil) {
                msg.priority = Message.Priority(rawValue: priority)!
            } else {
                //log.error("parsing priority failed. mid: \(mid)")
            }
            
            if (Message.Status(rawValue: status) != nil) {
                msg.status = Message.Status(rawValue: status)!
            } else {
                //log.error("parsing status failed. mid: \(mid)")
            }
            
            msg.add_time = add_time
            msg.update_time = update_time
            
            print(add_time)
            //log.debug(msg.description)
            
            returnList += [msg]
        }
        
        //log.debug("parsed \(returnList.count) messages")
        return returnList
    }

}
