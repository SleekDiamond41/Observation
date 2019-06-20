//
//  Token.swift
//  
//
//  Created by Michael Arrington on 6/7/19.
//

import Foundation


/// An object that manages observing and performing an action when an event is triggered.
///
/// - Note: Once a Token has been invalidated it cannot be revalidated; a new one must be generated.
public class Token<T: Observable> {
	private var action: (T) -> Void
	private let notifier: NotificationCenter
	
	init<U>(notifier: NotificationCenter, object: T, event: U, action: @escaping (T) -> Void) where T.ObservationEvent == U {
		self.action = action
		self.notifier = notifier
		
		notifier.addObserver(self, selector: #selector(act), name: NSNotification.Name(event.observationName), object: object)
	}
	
	deinit {
		invalidate()
	}
	
	/// Stop observing events. This happens automatically when a Token is deinitialized.
	public func invalidate() {
		notifier.removeObserver(self)
		action = { _ in }
	}
	
	@objc private func act(_ note: Notification) {
		
		guard let info = note.userInfo else {
			return
		}
		guard let obj = info[objectKey] else {
			return
		}
		guard let object = obj as? T else {
			return
		}
		
		self.action(object)
	}
}
