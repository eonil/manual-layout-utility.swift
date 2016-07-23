//
//  CommonFeature.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import Foundation
import AppKit
import CoreGraphics

enum CommonFeature {
    case placeholder
    case image(CommonImage)
    case text(CommonText)
    case button(CommonButton)
}
enum CommonImage {
    case inline(NSImage)
    case link(NSURL)
}
enum CommonText {
    case plain(String)
    case rich(NSAttributedString)
}
enum CommonButton {
    case imageOnly(CommonImage)
    case textOnly(CommonText)
    case imageAndText(CommonImage, space:CGFloat, CommonText)
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension CommonFeature: Measurable {
    func sizeThatFits(budget: CGSize) -> CGSize {
        switch self {
        case .placeholder:      return CGSize.zero
        case .image(let s):     return s.sizeThatFits(budget)
        case .text(let s):      return s.sizeThatFits(budget)
        case .button(let s):    return s.sizeThatFits(budget)
        }
    }
}
extension CommonImage: Measurable {
    func sizeThatFits(budget: CGSize) -> CGSize {
        switch self {
        case .inline(let s):    return s.size
        case .link(_):          return CGSize.zero
        }
    }
}
extension CommonText: Measurable {
    func sizeThatFits(budget: CGSize) -> CGSize {
        let opts = NSStringDrawingOptions([.UsesFontLeading, .UsesLineFragmentOrigin])
        switch self {
        case .plain(let s):     return NSAttributedString(string: s).boundingRectWithSize(budget, options: opts, context: nil).size
        case .rich(let s):      return s.boundingRectWithSize(budget, options: opts, context: nil).size
        }
    }
}
extension CommonButton: Measurable {
    func sizeThatFits(budget: CGSize) -> CGSize {
        // Button size need to be defined by container piece
        // because we cannot fully emulate system's layout behavior.
        // Especially, if you're using a bordered button, it goes
        // impossible how much border volumes you have to add.
        return CGSize.zero
    }
}









