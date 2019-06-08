//
//  Notifier.swift
//  
//
//  Created by Michael Arrington on 6/7/19.
//

import class NotificationCenter.NotificationCenter
import class Foundation.DispatchQueue


/// A shared NotificationCenter instance on which Observations take place
internal let notifier = NotificationCenter()


/// A shared DispatchQueue on which to send out/receive Notifications
internal let queue = DispatchQueue(label: "com.duct-ape.Observation.queue", qos: .userInitiated, attributes: .concurrent)


/// A key used when passing an object in UserInfo through a Notification
internal let objectKey = "object"
