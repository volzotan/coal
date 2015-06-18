//
//  ViewController.swift
//  Coal
//
//  Created by Christopher Getschmann on 24.05.15.
//  Copyright (c) 2015 Christopher Getschmann. All rights reserved.
//

import UIKit
import XCGLogger
import SwiftyJSON
import Alamofire

class ViewController: UITableViewController {

    @IBOutlet var messageList: UITableView!
    
    let calciferConnector = CalciferConnector.instance
    let localstore = Localstore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshListener:", name:"RefreshUI", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadAndRefreshListener:", name:"LoadAndRefreshUI", object: nil)
        
        // remove gap on the left side of the cell separator
        messageList.separatorInset = UIEdgeInsetsZero
        
        addExampleMessages()
        fireNotification()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector(), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        
        loadDataAndRefresh()
    }
    
    func refreshListener(notification: NSNotification){
        refresh()
    }
    
    func loadAndRefreshListener(notification: NSNotification){
        loadDataAndRefresh()
    }
    
    func refresh() -> Void {
        self.messageList?.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func loadDataAndRefresh() -> Void {
        calciferConnector.getAllMessages(self.addMessages, callbackError: self.displayError)
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        loadDataAndRefresh()
    }
    
    func addMessages(messageList: [Message]) -> Void {
        self.localstore.add(messageList)
        calciferConnector.setAllAsRead(localstore.getAllAsMids(), callbackError: displayError)
        refresh()
    }
    
    func displayError(status: Int?) -> Void {
        if let code = status {
            switch (code) {
            case 401:
                let alertController = UIAlertController(
                    title: NSLocalizedString("alert.unauthorized.title", comment: ""),
                    message: NSLocalizedString("alert.unauthorized.body", comment: ""),
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: NSLocalizedString("alert.dismiss", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            default:
                break
            }
        }
        
        self.messageList?.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    @IBAction func trashButton(sender: AnyObject) {
        localstore.clear()
        refresh()
    }
    
    // tableView functions //

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localstore.count();
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "messageCell"
        var cell: MessageTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MessageTableViewCell
        
        if cell == nil {
            cell = MessageTableViewCell(style: .Default, reuseIdentifier: cellIdentifier);
        }
        
        // remove gap on the left side of the cell separator
        cell!.layoutMargins = UIEdgeInsetsZero
        
        cell!.populate(self.localstore.getAtPosition(indexPath.row)!)
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 20
        let message: Message? = self.localstore.getAtPosition(indexPath.row)
        if message != nil {
            //height = CGFloat(count(message!.payload) / 2)
            height = heightForView(message!.payload, width: 250.0)
            //println(height)
        }
        return height + 15.0
    }
    
    func heightForView(text:String, width:CGFloat) -> CGFloat{
        let font = UIFont(name: "System", size: 15.0)
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func fireNotification() {
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = NSDate() // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": 126] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        log.debug("notification")
    }
    
    func addExampleMessages() {
        let msg1 = Message(mid: "111", payload: "internal message internal message internal internal message internal internal message internal internal message internal")
        let msg2 = Message(mid: "112", payload: "internal message internal message internal internal message internal ")
        let msg3 = Message(mid: "113", payload: "silent internal message")
        let msg4 = Message(mid: "114", payload: "silent internal message")
        
        msg1.add_time = NSDate()
        msg2.add_time = NSDate()
        msg3.add_time = NSDate()
        msg2.priority = Message.Priority.High
        msg1.priority = Message.Priority.Silent
        
        self.localstore.add(msg1)
        self.localstore.add(msg2)
        self.localstore.add(msg3)
        self.localstore.add(msg4)
    }

}

