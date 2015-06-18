//
//  MessageUtil.swift
//  Coal
//
//  Created by Christopher Getschmann on 29.05.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

import XCGLogger
import SwiftyJSON

class MessageUtil: NSObject {
    
    let dateFormat: String = "YYYY-MM-dd HH:mm:ss.SSSSSSZ"
    
    func parseJSON(json: JSON) -> [Message] {
        var returnList = [Message]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        for (_, jsonmsg): (String, JSON) in json {
            let mid: String = jsonmsg["message"]["mid"].stringValue
            let payload: String = jsonmsg["message"]["payload"].stringValue
            
            let priority: String = jsonmsg["message"]["priority"].stringValue
            let status: String = jsonmsg["message"]["status"].stringValue
            
            let add_time = dateFormatter.dateFromString(jsonmsg["add_time"].stringValue)
            let update_time = dateFormatter.dateFromString(jsonmsg["update_time"].stringValue)
            
            let sender: String = jsonmsg["sender"].stringValue
            
            let msg = Message(mid: mid, payload: payload)
            
            if (Message.Priority(rawValue: priority) != nil) {
                msg.priority = Message.Priority(rawValue: priority)!
            } else {
                log.error("parsing priority failed. mid: \(mid)")
            }
            
            if (Message.Status(rawValue: status) != nil) {
                msg.status = Message.Status(rawValue: status)!
            } else {
                log.error("parsing status failed. mid: \(mid)")
            }
            
            msg.add_time = add_time
            msg.update_time = update_time
            
            //print(add_time)
            log.debug(msg.description)
            
            returnList += [msg]
        }
        
        log.debug("parsed \(returnList.count) messages")
        return returnList
    }

}
