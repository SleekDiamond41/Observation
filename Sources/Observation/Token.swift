//
//  Token.swift
//  
//
//  Created by Michael Arrington on 6/7/19.
//

import Foundation


/// An object that manages observing and performing an action when an event is triggered.
public class Token<T>: AnyToken where T: Observable {
	private var action: ((T) -> Void)?
	private var notifier: NotificationCenter?
    private var queue: DispatchQueue?

    init(notifier: NotificationCenter, queue: DispatchQueue?, object: T, event: T.ObservationEvent, action: @escaping (T) -> Void) {
		self.action = action
		self.notifier = notifier
        self.queue = queue
		
		notifier.addObserver(self, selector: #selector(act), name: NSNotification.Name(event.observationName), object: object)
	}
	
	deinit {
		invalidate()
	}
	
	public func invalidate() {
		notifier?.removeObserver(self)
        notifier = nil
        queue = nil
		action = nil
	}

	@objc private func act(_ note: Notification) {
        guard let action = action else {
            return
        }

        assert(note.userInfo != nil)
        assert(note.userInfo?[objectKey] != nil)
        assert(note.userInfo?[objectKey] is T)

        guard let object = note.userInfo?[objectKey] as? T else {
            return
        }

        if let queue = queue {
            queue.async { action(object) }
        } else {
            action(object)
        }
	}
}
