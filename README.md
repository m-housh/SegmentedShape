# SegmentedShape

[![Build Status](https://travis-ci.org/m-housh/SegmentedShape.svg?branch=master)](https://travis-ci.org/m-housh/SegmentedShape)
[![codecov](https://codecov.io/gh/m-housh/SegmentedShape/branch/master/graph/badge.svg)](https://codecov.io/gh/m-housh/SegmentedShape)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-blueviolet.svg?style=flat)](https://swift.org/package-manager/)
[![Swift](https://img.shields.io/badge/iOS-13-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

A SwiftUI package that allows shapes to be broken into segments.  The segments that get drawn at a given time can also be controlled for animations.

## Example
-----------
In this example we will build the following animation that draws each segment of a square, line by line.

![](SegmentedSquareDrawing.gif)

```swift

import SwiftUI
import SegmentedShape

struct SegmentedSquare: SegmentedShape {

    var showing: SegmentsShown = .all

    // Note: The container passed into a `Segment` closure contains the
    // current path state and a reference to the bounding `CGRect`.  The same
    // container will get passed to following `Segment`'s ending the drawing
    // based on the `showing` variable.
    
    static var segments = Segments {
        // left
        Segment { container in
            let maxY = container.rect.maxY
            container.path.move(to: CGPoint(x: 0, y: maxY))
            container.path.addLine(to: CGPoint(x: 0, y: 0))
        }
        // top
        Segment { container in
            let maxX = container.rect.maxX
            container.path.addLine(to: CGPoint(x: maxX, y: 0))
        }
        // right
        Segment { container in
            let maxX = container.rect.maxX
            let maxY = container.rect.maxY
            container.path.addLine(to: CGPoint(x: maxX, y: maxY))
        }
        // bottom
        Segment { container in
            let maxY = container.rect.maxY
            container.path.addLine(to: CGPoint(x: 0, y: maxY))
        }
    }
}

struct ContentView: View {
    
    @State var segmentsShown: SegmentsShown = .none
        
    var body: some View {
        ZStack {
            SegmentedSquare(showing: segmentsShown)
                .stroke()
                .frame(width: 300, height: 300, alignment: .center)
        }
        .onAppear() {
            // Animate the drawing of the square line by line.
            for i in 0...SegmentedSquare.segments.count {
                let interval = Double(i) * 0.5 + 0.1
                Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
                    self.segmentsShown = .max(i)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```

