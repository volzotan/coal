//
//  Message.swift
//  Coal
//
//  Created by Christopher Getschmann on 27.05.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

class Message: CustomStringConvertible {
    
    enum Status: String {
        case    Read = "read",
                Delivered = "delivered",
                Sent = "sent",
                Unknown = "unknown",
                Failed = "failed"
    }
    
    enum Priority: String {
        case    High = "high",
                Medium = "medium",
                Low = "low",
                Silent = "silent"
    }
    
    var mid: String
    var payload: String
    
    var add_time: NSDate?
    var update_time: NSDate?
    var priority: Priority = Priority.Medium
    var status: Status = Status.Unknown
    var sender: String = ""
    
    init(mid: String, payload: String) {
        self.mid = mid
        self.payload = payload
    }
    
    var description: String {
        return "\(mid): \(payload) :: \(priority)"
    }

}
