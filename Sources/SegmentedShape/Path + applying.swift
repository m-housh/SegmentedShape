//
//  Path + applying.swift
//  
//
//  Created by Michael Housh on 11/29/19.
//

import SwiftUI

extension Path {

    /// Applys a `Segment` to the path.
    ///
    /// - parameter segment: The `Segment` to apply.
    /// - parameter rect: The  bounding `CGRect`
    ///
    public func applying(segment: Segment, in rect: CGRect) -> Path {
        let container = SegmentedPathContainer(path: self, in: rect)
        segment.run(on: container)
        return container.path
    }
}
