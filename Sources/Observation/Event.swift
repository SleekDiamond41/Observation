//
//  Event.swift
//  
//
//  Created by Michael Arrington on 6/7/19.
//


/// An event that may be observed
///
/// Values may be common across different Observable types, but each Event's observationName must be unique within its Observable type. The following example is valid even though the events share a name, because they will be used on different objects.
///
/// ```
/// class Foo: Observable {
///
///   enum ObservationEvent: String, Event {
///     case willUpdate
///     case didUpdate
///   }
/// }
///
/// class Bar: Observable {
///
///   enum ObservationEvent: String, Event {
///     case willUpdate
///     case didUpdate
///   }
/// }
/// ```
/// The following is also valid.
/// ```
/// enum SharedEvent: Event {
///   case willUpdate
///   case didUpdate
///
///   var observationName: String {
///     switch self {
///       case .willUpdate: return "willUpdate"
///       case .didUpdate: return "didUpdate"
///     }
///   }
/// }
///
/// class Foo: Observable {
///   typealias ObservationEvent = SharedEvents
/// }
///
/// class Bar: Observable {
///   typealias ObservationEvent = SharedEvents
/// }
/// ```
/// The following would not be valid, because different events use the same name.
/// ```
/// class Foo: Observable {
///
///   struct ObservationEvent: Event {
///     let observationName: String
///
///     static let willUpdate = ObservationEvent(observationName: "update")
///     static let didUpdate = ObservationEvent(observationName: "update")
///   }
/// }
/// ```
/// - Note: Using values described as "invalid" will be execute but may result in unexpected behavior.
public protocol Event {
	
	/// The name of an event.
	var observationName: String { get }
}

extension Event where Self: RawRepresentable, Self.RawValue == String {
	public var observationName: String {
		return rawValue
	}
}

