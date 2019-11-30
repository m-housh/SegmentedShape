//
//  Segment.swift
//  
//
//  Created by Michael Housh on 11/29/19.
//

/**
 # Segment

 A  container that holds a closure that can be used to draw a segment in a `SegmentedPathContainer`.
 
 */
public struct Segment {

    /// The signature of a `Closure`
    public typealias Closure = (SegmentedPathContainer) -> Void

    private let closure: Closure

    /// Create a new `Segment`
    ///
    /// - parameter closure: The `Closure` used to create the segment.
    ///
    public init(_ closure: @escaping Closure) {
        self.closure = closure
    }

    /// Run the `Closure` on the given container.
    ///
    /// - parameter container: The `SegmentedPathContainer` to run the closure on.
    public func run(on container: SegmentedPathContainer) {
        closure(container)
    }
}
