//
//  StackFlowDirection.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

#if os(OSX)
    import AppKit
#endif

public enum StackFlowDirection {
    case leadingToTrailing
    case trailingToLeading
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
}
public extension StackFlowDirection {
    public func opposite() -> StackFlowDirection {
        switch self {
        case .leadingToTrailing:    return .trailingToLeading
        case .trailingToLeading:    return .leadingToTrailing
        case .topToBottom:          return .bottomToTop
        case .bottomToTop:          return .topToBottom
        case .leftToRight:          return .rightToLeft
        case .rightToLeft:          return .leftToRight
        }
    }
}
extension StackFlowDirection {
    func getAxis() -> StackAxis {
        switch self {
        case .leadingToTrailing:    return .x
        case .trailingToLeading:    return .x
        case .topToBottom:          return .y
        case .bottomToTop:          return .y
        case .leftToRight:          return .x
        case .rightToLeft:          return .x
        }
    }
    func isMinToMax() -> Bool {
        #if os(OSX)
            let d = NSApplication.sharedApplication().userInterfaceLayoutDirection
            switch self {
            case .leadingToTrailing:    return d == .LeftToRight
            case .trailingToLeading:    return d == .RightToLeft
            case .topToBottom:          return false
            case .bottomToTop:          return true
            case .leftToRight:          return true
            case .rightToLeft:          return false
            }
        #endif
        #if os(iOS)
            let d = NSApplication.sharedApplication().userInterfaceLayoutDirection
            switch self {
            case .leadingToTrailing:    MARK_unimplemented()
            case .trailingToLeading:    MARK_unimplemented()
            case .topToBottom:          return true
            case .bottomToTop:          return false
            case .leftToRight:          return true
            case .rightToLeft:          return false
            }
        #endif
    }
}
extension SequenceType {
    func considering(flowDirection: StackFlowDirection) -> [Generator.Element] {
        if flowDirection.isMinToMax() {
            return Array(self)
        }
        else {
            return reverse()
        }
    }

}






