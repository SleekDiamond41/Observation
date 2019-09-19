//
//  Observable.swift
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
    ///
    /// - Note: action will be executed asynchronously on an internal, concurrent queue with the DispatchQoS.userInitiated quality of service.
    ///
    /// - Parameters:
    ///   - event: the event that should trigger the closure
    ///   - action: an action to perform
    ///
	/// - Returns: A token that manages listening for and reacting to the specified event.
	public func on(_ event: ObservationEvent, do action: @escaping (Self) -> Void) -> Token<Self> {
        return on(event, queue: nil, notifier: notifier, do: action)
	}

    /// Registers a closure to execute every time an event is triggered, until the ObservationToken has been invalidated.
    ///
    /// - Parameters:
    ///   - event: the event that should trigger the closure
    ///   - queue: the queue on which the task should be asynchronously executed
    ///   - action: an action to perform
    ///
    /// - Returns: A token that manages listening for and reacting to the specified event.
    public func on(_ event: ObservationEvent, queue: DispatchQueue, do action: @escaping (Self) -> Void) -> Token<Self> {
        return on(event, queue: queue, notifier: notifier, do: action)
    }
	
    private func on(_ event: ObservationEvent, queue: DispatchQueue?, notifier: NotificationCenter, do action: @escaping (Self) -> Void) -> Token<Self> {
        return Token(notifier: notifier, queue: queue, object: self, event: event, action: action)
	}
	
	
	/// Posts the event, notifying any observers.
    ///
	/// - Parameter event: an event to be posted
	public func notify(_ event: ObservationEvent) {
        notify(event, notifier: notifier, queue: queue)
	}
	
    private func notify(_ event: ObservationEvent, notifier: NotificationCenter, queue: DispatchQueue) {
		queue.async {
			let note = Notification(name: Notification.Name(event.observationName), object: self, userInfo: [objectKey: self])
			notifier.post(note)
		}
	}
}
