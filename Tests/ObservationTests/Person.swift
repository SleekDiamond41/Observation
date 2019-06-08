//
//  File.swift
//  
//
//  Created by Michael Arrington on 6/8/19.
//

import Foundation
import Observation

class Person {}

// conformance
extension Person: Observable {
	
	enum ObservationEvent: String, Observation.Event {
		case didRefresh
	}
}
