//
//  SegmentedPathContainer.swift
//  
//
//  Created by Michael Housh on 11/29/19.
//

import SwiftUI

/**
 # SegmentedPathContainer
 
 Holds the `Path` and bounding `CGRect` while a `Segment`(s) is being processed.
 
 */
public final class SegmentedPathContainer {

    /// The current `Path`
    public var path: Path

    /// The bounding `CGRect`
    public let rect: CGRect

    /// Create a new `SegmentedPathContainer`
    ///
    /// - parameter path: The  current `Path`.
    /// - parameter rect: The bounding `CGRect`
    ///
    public init(path: Path = Path(), in rect: CGRect) {
        self.path = path
        self.rect = rect
    }
}
