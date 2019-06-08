# Observation

## What
Observation is a simple framework that manages the subscription to and observation of arbitrary events on arbitrary objects, all in a type-safe manner. Simply put, you can define events for a type and subscribe to said events. For example:
```swift
import Observation

class Person {
	var name = ""
}

// conformance
extension Person: Observable {
	enum ObservationEvent: String, Observation.Event {
		case didUpdate
	}
}

let person = Person()
var token: Token<Person>? = person.when(.didRefresh) { (p) in
	print("Hello, \(p.name)!")
}

person.name = "Johnny Appleseed"
person.post(.didUpdate)

// prints "Hello, Johnny, Appleseed!"
```


## How
Observation is currently powered by NotificationCenter, but that may be subject to change. 

Notifications are generated and posted to a private NotificationCenter instance on a private, concurrent DispatchQueue with the `.userInitiated` priority. 
