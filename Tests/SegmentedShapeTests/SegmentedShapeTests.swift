import XCTest
import SwiftUI
@testable import SegmentedShape

struct SegmentedSquare: SegmentedShape {

    var showing: SegmentsShown = .all

    static var segments = Segments {
        // left
        Segment { container in
            let maxY = container.rect.maxY
            container.path.move(to: .init(x: 0, y: maxY))
            container.path.addLine(to: .init(x: 0, y: 0))
        }
        // top
        Segment { container in
            let maxX = container.rect.maxX
            container.path.addLine(to: .init(x: maxX, y: 0))
        }
        // right
        Segment { container in
            let maxX = container.rect.maxX
            let maxY = container.rect.maxY
            container.path.addLine(to: .init(x: maxX, y: maxY))
        }
        // bottom
        Segment { container in
            let maxY = container.rect.maxY
            container.path.addLine(to: .init(x: 0, y: maxY))
        }
    }
}

struct DefaultSegmentedSquare: SegmentedShape {

    static var segments = SegmentedSquare.segments
}

final class SegmentedShapeTests: XCTestCase {

    func testSegmentedSquareSegments() {
        XCTAssertEqual(SegmentedSquare.segments.count, 4)
    }

    func testPathApplyingBuildsReturnsNewPath() {
        let path = Path()
        let newPath = path.applying(segment: SegmentedSquare.segments.allSegments[0], in: .init())
        XCTAssertNotEqual(path, newPath)
    }

    func testSegmentedSquarePath() {
        let rect = CGRect(x: 100, y: 100, width: 100, height: 100)
        let square1 = SegmentedSquare().path(in: rect)
        let square2 = SegmentedSquare().path(in: rect)
        XCTAssertEqual(square1, square2)
    }

    func testSegmentsShown() {
        let rect = CGRect(x: 100, y: 100, width: 100, height: 100)
        var square = SegmentedSquare()
        let path1 = square.path(in: rect)

        square.showing = .max(2)
        let path2 = square.path(in: rect)

        square.showing = .none
        let path3 = square.path(in: rect)

        XCTAssertNotEqual(path1, path2)
        XCTAssertNotEqual(path2, path3)
        XCTAssertNotEqual(path1, path3)
        XCTAssertEqual(Path(), path3)
    }

    func testSegmentsInitialaziation() {
        let segments = SegmentedSquare.segments.allSegments
        let newSegments = Segments(segments: segments)
        XCTAssertEqual(newSegments.count, 4)
    }

    func testDefaultSegmentedSquare() {
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let path = SegmentedSquare().path(in: rect)
        let path2 = DefaultSegmentedSquare().path(in: rect)
        XCTAssertEqual(path, path2)
    }

    static var allTests = [
        ("testSegmentedSquareSegments", testSegmentedSquareSegments),
        ("testPathApplyingBuildsReturnsNewPath", testPathApplyingBuildsReturnsNewPath),
        ("testSegmentedSquarePath", testSegmentedSquarePath),
        ("testSegmentsShown", testSegmentsShown),
        ("testSegmentsInitialaziation", testSegmentsInitialaziation),
        ("testDefaultSegmentedSquare", testDefaultSegmentedSquare)
    ]
}
