//
//  Measuring.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import CoreGraphics

//private protocol MeasurableFeaturePieceProtocol: PieceProtocol {
//    associatedtype Feature: Measurable
//}
public extension Piece {
    /// Resolves a size that fits within the budget as much as possible.
    func sizeThatFits(budget: CGSize) -> CGSize {
        /// Uses dynamic type query to simplify implementation.
        /// I think it's also possible to make it fully static,
        /// but also needs to make many duplicated code which is
        /// harder to maintain. Trade performance for 
        /// maintenance-ability.
        let fsz = (feature as? Measurable)?.sizeThatFits(budget) ?? CGSize.zero
        func getWithoutConstraints() -> CGSize {
            switch layout {
            case .over(_):
                let ssz = subpieces.map({ p in p.sizeThatFits(budget) }).reduce(CGSize.zero, combine: max)
                return max(fsz, ssz)
            case .stack(let flow):
                let axis = flow.getAxis()
                let maxBudget = CGSize(axis: axis, length: CGFloat.max, volume: budget.volume(in: axis))
                let szs = subpieces.considering(flow).map({ p in p.sizeThatFits(maxBudget) })
                let sz = szs.reduce(CGSize.zero, combine: compositeStackSubpieceSizes(axis))
                return max(fsz, sz)
            }
        }
        return getWithoutConstraints() | atLeast(getMinSize()) | atMost(getMaxSize())
    }
}

private func compositeStackSubpieceSizes(axis: Axis) -> (CGSize, CGSize) -> (CGSize) {
    return { a, b in CGSize(axis: axis,
                            length: a.length(in: axis) + b.length(in: axis),
                            volume: a.volume(in: axis) + b.volume(in: axis)) }
}














