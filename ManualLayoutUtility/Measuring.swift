//
//  Measuring.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import CoreGraphics

extension PieceProtocol {
//    /// Resolves a size that fits within the budget as much as possible.
//    /// By default, piece just uses minimum size.
//    func fittingSize(in budget: CGSize) -> CGSize {
//        return getMinSize()
//    }
    func sizeThatFits(budget: CGSize) -> CGSize {
        /// A piece with unmeasurable featuer cannot determine its size,
        /// so make it zero so to be hidden.
        return CGSize.zero | atLeast(getMinSize()) | atMost(getMaxSize())
    }
}

extension PieceProtocol where Feature: Measurable {
//    /// Resolves a size that fits within the budget as much as possible.
//    /// Consider feature's size if feature is measurable.
//    func fittingSize(in budget: CGSize) -> CGSize {
//        switch layout {
//        case .over(_):
//            let fsz = feature?.fittingSize(in: budget) ?? CGSize.zero
//            let m = OverLayoutMemo(self)
//            let sz = m.largestMinSizeFromAllDescendants
//            return max(sz, fsz)
//        case .stack(let axis):
//            return fittingSize(in: budget, stack: axis)
//        }
//    }
//    private func fittingSize(in budget: CGSize, stack axis: StackAxis) -> CGSize {
//        let fsz = feature?.fittingSize(in: budget) ?? CGSize.zero
//        let m = StackLayoutMemo(self)
//        let l = m.sumOfAllMinLength(in: axis)
//        let v = m.maxLength(in: axis.perpendicular())
//        let sz = CGSize(axis: axis, length: l, volume: v)
//        return max(sz, fsz)
//    }
    func sizeThatFits(budget: CGSize) -> CGSize {
        func getWithoutConstraints() -> CGSize {
            switch layout {
            case .over(_):
                let fsz = feature?.sizeThatFits(budget) ?? CGSize.zero
                let ssz = subpieces.map({ p in p.sizeThatFits(budget) }).reduce(CGSize.zero, combine: max)
                return max(fsz, ssz)
            case .stack(let flow):
                let axis = flow.getAxis()
//                let maxLen = atMost(CGFloat.max)
//                let maxVol = atMost(budget.volume(in: axis))
                let maxBudget = CGSize(axis: axis, length: CGFloat.max, volume: budget.volume(in: axis))
                let szs = subpieces.considering(flow).map({ p in p.sizeThatFits(maxBudget) })
                let sz = szs.reduce(CGSize.zero, combine: compositeStackSubpieceSizes(axis))
                return sz
            }
        }
        return getWithoutConstraints() | atLeast(getMinSize()) | atMost(getMaxSize())
    }
}
private func compositeStackSubpieceSizes(axis: StackAxis) -> (CGSize, CGSize) -> (CGSize) {
    return { a, b in CGSize(axis: axis,
                            length: a.length(in: axis) + b.length(in: axis),
                            volume: a.volume(in: axis) + b.volume(in: axis)) }
}














