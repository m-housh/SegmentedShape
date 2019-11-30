//
//  Segments.swift
//  
//
//  Created by Michael Housh on 11/29/19.
//

/**
 # Segments
 
 Holds a group of `Segment`s that together build a `SegmentedShape`.

 */
public struct Segments {

    /// All the `Segment` closures to build a `SegmentedShape`
    public let allSegments: [Segment]

    /// A function builder that allows `Segments` to be initialized
    /// without using commos between `Segment`s.
    @_functionBuilder
    public struct Builder {

        /// The builder function.
        public static func buildBlock(_ segments: Segment...) -> [Segment] {
            return segments
        }
    }

    /// Create a new `Segments` instance using the `Builder`
    ///
    ///  Example:
    ///  -------
    ///
    ///  ```
    ///  let segments = Segments {
    ///
    ///     Segment { container in
    ///         container.move(to: CGPoint(x: 0, y: container.rect.maxY))
    ///         container.addLine(to: CGPoint(x: 0, y: 0))
    ///     }
    ///
    ///     Segment { container in
    ///         container.addLine(to: CGPoint(x: container.rect.maxX, y: 0))
    ///     }
    /// }
    ///```
    ///
    ///
    public init(@Builder _ builder: () -> [Segment]) {
        self.allSegments = builder()
    }

    /// Create a new `Segments` instance.
    ///
    /// - parameter segments: The array of`Segment`'s to use
    ///
    public init(segments: [Segment]) {
        self.allSegments = segments
    }

    /// The count of the `Segment`'s in this instance.
    public var count: Int { allSegments.count }
}
