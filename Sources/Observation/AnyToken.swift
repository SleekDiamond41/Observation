//
//  AnyToken.swift
//  Observation
//
//  Created by Michael Arrington on 9/19/19.
//

public protocol AnyToken: AnyObject {

    /// Stop observing events. This is called automatically when a Token is deinitialized, but may be called manually to ensure the given token is invalidated immediately.
    ///
    /// - Note: Once a Token has been invalidated it cannot be revalidated; a new one must be generated.
    func invalidate()
}
