//
//  Axis.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/24.
//  Copyright © 2016 Eonil. All rights reserved.
//

enum Axis {
    case x
    case y
}
extension Axis {
    func perpendicular() -> Axis {
        switch self {
        case .x:    return .y
        case .y:    return .x
        }
    }
}
