//
//  CommonFeature.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import Foundation
import CoreGraphics
import AppKit

public enum CommonFeature {
    case placeholder
    case image(CommonImage)
    case text(CommonText)
//    case button(CommonButton)
}
public enum CommonImage {
    case inline(NSImage)
    case link(NSURL)
}
public enum CommonText {
    case plain(String)
    case rich(NSAttributedString)
}
public struct CommonButton {
    var image: CommonImage
    var text: CommonText
    var id: CommonButtonID
}
public struct CommonButtonID: Hashable {
    private let oid = NonObjectiveCBase()
    public var hashValue: Int {
        return ObjectIdentifier(oid).hashValue
    }
}
public func == (a: CommonButtonID, b: CommonButtonID) -> Bool {
    return a.oid === b.oid
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension CommonFeature: Measurable {
    public func sizeThatFits(budget: CGSize) -> CGSize {
        switch self {
        case .placeholder:      return CGSize.zero
        case .image(let s):     return s.sizeThatFits(budget)
        case .text(let s):      return s.sizeThatFits(budget)
//        case .button(let s):    return s.sizeThatFits(budget)
        }
    }
}
extension CommonImage: Measurable {
    public func sizeThatFits(budget: CGSize) -> CGSize {
        switch self {
        case .inline(let s):    return s.size
        case .link(_):          return CGSize.zero
        }
    }
}
extension CommonText: Measurable {
    public func sizeThatFits(budget: CGSize) -> CGSize {
        let opts = NSStringDrawingOptions([.UsesFontLeading, .UsesLineFragmentOrigin])
        switch self {
        case .plain(let s):     return NSAttributedString(string: s).boundingRectWithSize(budget, options: opts, context: nil).size
        case .rich(let s):      return s.boundingRectWithSize(budget, options: opts, context: nil).size
        }
    }
}
extension CommonButton: Measurable {
    public func sizeThatFits(budget: CGSize) -> CGSize {
        // Button size need to be defined by container piece
        // because we cannot fully emulate system's layout behavior.
        // Especially, if you're using a bordered button, it goes
        // impossible how much border volumes you have to add.
        return CGSize.zero
    }
}









