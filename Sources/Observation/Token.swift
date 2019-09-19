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

    init(notifier: NotificationCenter, queue: DispatchQueue, object: T, event: T.ObservationEvent, action: @escaping (T) -> Void) {
		self.action = action
		self.notifier = notifier
		
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
		
		queue?.async {
			guard let info = note.userInfo else {
				return
			}
			guard let obj = info[objectKey] else {
				return
			}
			guard let object = obj as? T else {
				return
			}
			
			action(object)
		}
	}
}
