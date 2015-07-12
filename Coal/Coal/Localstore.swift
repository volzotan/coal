//
//  Localstore.swift
//  Coal
//
//  Created by Christopher Getschmann on 04.06.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

class Localstore: NSObject {
    
    var messagestore = Dictionary<String, Message>()
    
    func add(message: Message) -> Void {
        if !contains(message.mid) {
            messagestore[message.mid] = message
        } else {
            log.debug("adding failed, duplicate mid: \(message.mid)")
        }
    }
    
    func add(messageList: [Message]) -> Void {
        for msg in messageList {
            add(msg)
        }
    }
    
    func remove(message: Message) -> Void {
        messagestore.removeValueForKey(message.mid)
    }
    
    func remove(mid: String) -> Void {
        messagestore.removeValueForKey(mid)
    }
    
    func get(mid: String) -> Message? {
        return messagestore[mid]
    }
    
    func getAll() -> [Message] {
        var arr: [Message] = []
        for (_, value) in self.messagestore {
            arr += [value]
        }
        
        return arr
    }
    
    func getAllAsMids() -> [String] {
        var mids: [String] = []
        for elem in self.getAll() {
            mids += [elem.mid]
        }
        
        return mids
    }
    
    func getAtPosition(pos: Int) -> Message? {
        var arr : [Message] = self.messagestore.values.array
        arr.sortInPlace({$0.mid > $1.mid})
        
        return arr[pos]
    }
    
    func contains(message: Message) -> Bool {
        if (messagestore[message.mid] != nil) {
            return true
        } else {
            return false
        }
    }
    
    func contains(mid: String) -> Bool {
        if (messagestore[mid] != nil) {
            return true
        } else {
            return false
        }
    }
    
    func clear() -> Void {
        messagestore = Dictionary<String, Message>()
    }
    
    func count() -> Int {
        return messagestore.count
    }
   
}
