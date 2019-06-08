//
//  File.swift
//  
//
//  Created by Michael Arrington on 6/8/19.
//

import Foundation


protocol Delegate: AnyObject {
	func didUpdate()
}

class Model {
	weak var delegate: Delegate?
	
	func update() {
		// do things
		
		delegate?.didUpdate()
	}
}


class Thing: Delegate {
	func didUpdate() {
		print("Did Update!")
	}
}

class Callbacks {
	var onUpdate: () -> Void = {}
}

class Person {}
extension Person: Observable {
	typealias ObservationEvent = Event
	
	enum Event: String, Observation.Event {
		case didUpdate
	}
}

class Test {
	var token: Token<Person>?
	
	init() {
		// delegation
		let model = Model()
		let thing = Thing()
		model.delegate = thing
		
		// callbacks
		let caller = Callbacks()
		caller.onUpdate = {
			print("Did Update!")
		}
		
		// observation
		let person = Person()
		token = person.when(.didUpdate) { (p) in
			print("\(p) Did Update!")
		}
	}
	
}

