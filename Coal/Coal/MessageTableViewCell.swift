//
//  MessageTableViewCell.swift
//  Coal
//
//  Created by Christopher Getschmann on 31.05.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var payloadLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func populate(message: Message) -> Void {
        self.payloadLabel?.text = message.payload
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if (message.add_time != nil) {
            let dateString: String = dateFormatter.stringFromDate(message.add_time!)
            self.dateLabel?.text = dateString
        } else {
            self.dateLabel?.text = ""
        }
        
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.payloadLabel.textColor = UIColor.blackColor()
        self.dateLabel.textColor = UIColor.blackColor()
        
        switch (message.priority) {
        case Message.Priority.High:
            self.contentView.backgroundColor = Configuration.highColor
            self.payloadLabel.textColor = UIColor.whiteColor()
            self.dateLabel.textColor = UIColor.whiteColor()
        case Message.Priority.Medium:
            //self.contentView.backgroundColor = self.mediumColor
            break
        case Message.Priority.Low:
            //self.contentView.backgroundColor = self.lowColor
            break
        case Message.Priority.Silent:
            self.contentView.backgroundColor = Configuration.silentColor
            self.payloadLabel.textColor = UIColor.whiteColor()
            self.dateLabel.textColor = UIColor.whiteColor()
        }
        
    }
    
}
