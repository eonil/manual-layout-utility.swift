//
//  LayoutErrorRecovery.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

import CoreGraphics

public struct LayoutErrorRecovery {
    public var reason: LayoutError
    public var method: LayoutErrorRecoveryMethod

    public static var delegate: ((LayoutErrorRecovery) -> ())? {
        willSet {
            assert(delegate == nil, "You can set this only once.")
        }
    }
    func report() {
        guard let d = LayoutErrorRecovery.delegate else { return }
        d(self)
    }
}
public enum LayoutError: ErrorType {
    case budgetOverflow
}
public enum LayoutErrorRecoveryMethod {
    case clipByBounds(CGRect)
}