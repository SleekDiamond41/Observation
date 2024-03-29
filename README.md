# Observation

Observation is a simple framework that manages the subscription to and observation of arbitrary events on arbitrary objects, all in a type-safe manner. Simply put, you can define events for a type and subscribe to said events. For example:
```swift
import UIKit
import Observation

class Person {
	var name = ""
}

// conformance
extension Person: Observable {
	enum ObservationEvent: String, Event {  // alternatively "Observation.Event"
		case didUpdate
	}
}

class ViewController: UIViewController {
	var person: Person?
	var token: Token<Person>? // alternatively "Observation.Token<Person>?"

	func viewDidLoad() {
		super.viewDidLoad()

		token = person?.when(.didUpdate) { [weak self] (_) in
			self?.refreshUI()
		}
	}
  
	@IBAction func didEnterName(_ field: UITextField) {
		person?.name = field.text ?? ""
		person?.post(.didUpdate)
	}
  
	func refreshUI() {
		// ...
	}
}
```

## Why
NotificationCenter is a robust and powerful tool, but its API can be more difficult to interact with than beneficial. Observation wraps the complexity of NotificationCenter into a clean, flexible interaction. Observation is not meant to replace NotificationCenter; it is meant to make it easier to use for the majority of use cases.

## How
Observation is currently backed by NotificationCenter, but that may be subject to change. 

Notifications are generated and posted to an internal NotificationCenter instance on an internal, concurrent DispatchQueue with the `.userInitiated` priority to avoid blocking the main thread. Note that actions that are passed in will similarly be executed on the internal DispatchQueue instance, and any changes to UI should be off-boarded to DispatchQueue.main. 

## Contributing
This framework is meant to be flexible and simple. Do you have improvements? I'll be watching for pull requests. Alternatively, feel free to contact me with suggestions!

## Contact
Feel free to reach out with any questions and feedback by making an issue in this repository or email me at applejuice2014@icloud.com.
