//
//  StackLayout.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import CoreGraphics

public enum StackAxis {
    case x
    case y
}
extension StackAxis {
    func perpendicular() -> StackAxis {
        switch self {
        case .x:    return .y
        case .y:    return .x
        }
    }
}
