//
//  ManualLayoutUtilityCriticalError.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/27.
//  Copyright © 2016 Eonil. All rights reserved.
//

extension ManualLayoutUtilityCriticalError {
    public static var delegate: ((ManualLayoutUtilityCriticalError) -> ())?
    private static func cast(code: ManualLayoutUtilityCriticalErrorCode, message: String) {
        let m = message.isEmpty ? "\(code)" : message
        let e = ManualLayoutUtilityCriticalError(code: code, message: m)
        if let d = delegate {
            d(e)
        }
        else {
            // No delegate. Do default. Crash.
            fatalError("\(self)")
        }
    }
}

public struct ManualLayoutUtilityCriticalError: ErrorType {
    public var code: ManualLayoutUtilityCriticalErrorCode
    public var message: String
}
public enum ManualLayoutUtilityCriticalErrorCode {
    case unexpectedCommonFeatureRenderingViewFeatureViewClass(AnyClass)
}
extension ManualLayoutUtilityCriticalErrorCode {
    func report(message: String = "") {
        ManualLayoutUtilityCriticalError.cast(self, message: message)
    }
}
