//
//  SegmentsShown.swift
//  
//
//  Created by Michael Housh on 11/29/19.
//

/**
 # SegmentsShown
 
 Limits the `Segment` closures for a `SegmentedShape` which allows manipulation for animation.
 
 */
public enum SegmentsShown {
    case none
    case all
    case max(Int)
}
