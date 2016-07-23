//
//  Protocols.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import CoreGraphics

protocol Measurable {
    /// If possible, return a size within the budget.
    /// Overflown size also can be accepted if you
    /// just claim a certain size.
    /// Do not waste budget. Always claim minimal space
    /// that you need.
    func sizeThatFits(budget: CGSize) -> CGSize
}

protocol PieceProtocol: Measurable {
    associatedtype Feature
    var feature: Feature? { get }
    /// However feature is sized, feature size cannot overflow this constraints.
    var constraints: SizeConstraint { get }
    var layout: PieceLayout { get }
    var subpieces: [Self] { get }
    func arrange(in bounds: CGRect) -> Box<Feature>
}

public typealias SizeConstraint = (width: LengthConstraint, height: LengthConstraint)
public typealias LengthConstraint =  (min: CGFloat, max: CGFloat)



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension PieceProtocol {
    func capacity(in axis: StackAxis) -> CGFloat {
        let c = constraint(in: axis)
        return c.max - c.min | atLeast(0)
    }
    func constraint(in axis: StackAxis) -> LengthConstraint {
        switch axis {
        case .x:    return constraints.width
        case .y:    return constraints.height
        }
    }
    func getMinSize() -> CGSize {
        return CGSize(width: constraints.width.min, height: constraints.height.min)
    }
    func getMaxSize() -> CGSize {
        return CGSize(width: constraints.width.max, height: constraints.height.max)
    }
}
