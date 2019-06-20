//
//  File.swift
//  
//
//  Created by Michael Arrington on 6/7/19.
//

import class NotificationCenter.NotificationCenter
import struct NotificationCenter.Notification
import class Foundation.DispatchQueue

public protocol Observable: AnyObject {
	associatedtype ObservationEvent: Event
}

extension Observable {
	
	/// Registers a closure to execute every time an event is triggered, until the ObservationToken has been invalidated.
	/// - Parameter event: the event that should trigger the closure
	/// - Parameter action: an action to perform
	/// - Returns: A token that manages listening for and reacting to the specified event.
	public func when(_ event: ObservationEvent, do action: @escaping (Self) -> Void) -> Token<Self> {
		return when(event, notifier: notifier, do: action)
	}
	
	private func when(_ event: ObservationEvent, notifier: NotificationCenter, do action: @escaping (Self) -> Void) -> Token<Self> {
		return Token(notifier: notifier, object: self, event: event, action: action)
	}
	
	
	/// Posts the event, which will notify any observers.
	/// - Parameter event: an event to be posted
	public func post(_ event: ObservationEvent) {
		post(event, notifier: notifier, queue: queue)
	}
	
	private func post(_ event: ObservationEvent, notifier: NotificationCenter, queue: DispatchQueue) {
		queue.async {
			let note = Notification(name: Notification.Name(event.observationName), object: self, userInfo: [objectKey: self])
			notifier.post(note)
		}
	}
}
