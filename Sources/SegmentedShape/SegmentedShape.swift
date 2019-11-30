//
//  Segment.swift
//
//
//  Created by Michael Housh on 11/29/19.
//

import SwiftUI

/**
 # SegmentedShape
 
 A shape that can be drawn by different `Segment`s.  Can also limit the segments
 drawn at a given time.
 
 */
public protocol SegmentedShape: Shape {

    /// The `Segments` that can draw the entire shape.
    static var segments: Segments { get }

    /// Allows limiting the segments showing.
    /// - default: `.all`
    ///
    var showing: SegmentsShown { get }

//    init(showing: SegmentsShown)

}

extension SegmentedShape {

    public var showing: SegmentsShown { return .all }

    // Trims the segments based on `showing` value.
    private var segmentsShown: [Segment] {

        let segments = Self.segments.allSegments

        switch showing {
        case .all:
            return segments
        case .none:
            return []
        case .max(let max):
            return Array(segments.prefix(max))
        }
    }

    /// Generates a path based on current state and `showing`.
    ///
    /// - SeeAlso: `Shape`
    public func path(in rect: CGRect) -> Path {
        segmentsShown.reduce(Path()) { path, segment in
            return path.applying(segment: segment, in: rect)
        }
    }

}
