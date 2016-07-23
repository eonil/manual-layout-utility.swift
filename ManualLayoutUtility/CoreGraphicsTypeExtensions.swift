//
//  CoreGraphicsTypeExtensions.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/21.
//
//

import CoreGraphics
import AppKit

func + (a: CGSize, b: CGSize) -> CGSize {
    return CGSize(a.width + b.width, a.height + b.height)
}

func min (a: CGSize, _ b: CGSize) -> CGSize {
    return CGSize(min(a.width, b.width), min(a.height, b.height))
}

func max (a: CGSize, _ b: CGSize) -> CGSize {
    return CGSize(max(a.width, b.width), max(a.height, b.height))
}

func + (a: CGSize, b: NSEdgeInsets) -> CGSize {
    return CGSize(width: a.width + b.left + b.right,
                  height: a.height + b.top + b.bottom)
}

extension CGPoint {
    init(axis: StackAxis, position: CGFloat) {
        switch axis {
        case .x:
            x = position
            y = 0
        case .y:
            x = 0
            y = position
        }
    }
    func position(on axis: StackAxis) -> CGFloat {
        switch axis {
        case .x:    return x
        case .y:    return y
        }
    }
}
extension CGSize {
    init(_ width: CGFloat, _ height: CGFloat) {
        self = CGSize(width: width, height: height)
    }
    init(axis: StackAxis, length: CGFloat, volume: CGFloat) {
        switch axis {
        case .x:
            width = length
            height = volume
        case .y:
            width = volume
            height = length
        }
    }
    func length(in axis: StackAxis) -> CGFloat {
        switch axis {
        case .x:    return width
        case .y:    return height
        }
    }
    func volume(in axis: StackAxis) -> CGFloat {
        switch axis {
        case .x:    return height
        case .y:    return width
        }
    }
    func perpendicular() -> CGSize {
        return CGSize(width: height,
                      height: width)
    }
}
extension CGRect {
//    init(axis: StackAxis, midpoint: CGFloat, size: CGSize) {
//        switch axis {
//        case .x:
//            origin = CGPoint(x: midpoint - size.width/2,
//                             y: size.height/2)
//        case .y:    return midY
//        }
//    }
}
extension CGRect {
    func resized(to: CGSize) -> CGRect {
        return CGRect(x: midX - (to.width/2), y: midY - (to.width/2), width: to.width, height: to.height)
    }
    func minEdge(axis: StackAxis) -> CGRect {
        switch axis {
        case .x:    return CGRect(x: minX, y: minY, width: 0, height: height)
        case .y:    return CGRect(x: minX, y: minY, width: width, height: 0)
        }
    }
    func midEdge(axis: StackAxis) -> CGRect {
        switch axis {
        case .x:    return CGRect(x: midX, y: minY, width: 0, height: height)
        case .y:    return CGRect(x: minX, y: midY, width: width, height: 0)
        }
    }
    func maxEdge(axis: StackAxis) -> CGRect {
        switch axis {
        case .x:    return CGRect(x: maxX, y: minY, width: 0, height: height)
        case .y:    return CGRect(x: minX, y: maxY, width: width, height: 0)
        }
    }
    func displaced(axis: StackAxis, displacement: CGFloat) -> CGRect {
        switch axis {
        case .x:    return CGRect(x: minX + displacement, y: minY, width: width, height: height)
        case .y:    return CGRect(x: minX, y: minY + displacement, width: width, height: height)
        }
    }
    func advanceMaxEdge(axis: StackAxis, length: CGFloat) -> CGRect {
        switch axis {
        case .x:    return CGRect(x: maxX, y: minY, width: length, height: height)
        case .y:    return CGRect(x: minX, y: maxY, width: width, height: length)
        }
    }
    func resized(axis: StackAxis, to length: CGFloat) -> CGRect {
        switch axis {
        case .x:    return CGRect(x: midX - (length/2), y: minY, width: length, height: height)
        case .y:    return CGRect(x: minX, y: midY - (length/2), width: width, height: length)
        }
    }
    func midpoint(on axis: StackAxis) -> CGFloat {
        switch axis {
        case .x:    return midX
        case .y:    return midY
        }
    }
    @available(*,unavailable)
    func length(in axis: StackAxis) -> CGFloat {
        return size.length(in: axis)
    }
}
