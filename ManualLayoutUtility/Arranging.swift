//
//  Arranging.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

import CoreGraphics

public extension PieceProtocol {
    public func arrange(in bounds: CGRect) -> Box<Feature> {
        switch layout {
        case .over:
            return arrange(in: bounds, over: ())
        case .stack(let flow):
            return arrange(in: bounds, stack: flow)
        }
    }

    private func arrange(in bounds: CGRect, over _: ()) -> Box<Feature> {
        let sbs = subpieces.map({ p -> Box<Feature> in
            let sz = p.getMinSize() | atMost(bounds.size)
            let f = bounds.resized(sz)
            return p.arrange(in: f)
        })
        return Box(feature: feature,
                   frame: bounds,
                   subboxes: sbs)
    }
    private func arrange(in bounds: CGRect, stack flow: StackFlowDirection) -> Box<Feature> {
        let axis = flow.getAxis()
        let maxBudget = CGSize(axis: axis, length: CGFloat.max, volume: bounds.size.volume(in: axis))
        let szs = subpieces.map({ p in p.sizeThatFits(maxBudget) })
        let len = szs.map({ sz in sz.length(in: axis) }).reduce(0, combine: +)
        var f = bounds.midEdge(axis).displaced(axis, displacement: -len/2)
        let subboxes = zip(subpieces, szs).considering(flow).map({ sp, sz -> Box<Feature> in
            let c = sp.constraint(in: axis)
            let b1 = f.maxEdge(axis)
            let l1 = sz.length(in: axis) | atLeast(c.min) | atMost(c.max)
            let b2 = b1.advanceMaxEdge(axis, length: l1)
            f = b2.maxEdge(axis)
            let vc = sp.constraint(in: axis.perpendicular())
            let v = b2.size.volume(in: axis) | atLeast(vc.min) | atMost(vc.max)
            let b3 = b2.resized(axis.perpendicular(), to: v)
            return sp.arrange(in: b3)
        }).considering(flow)
        return Box(feature: feature,
                   frame: bounds,
                   subboxes: subboxes)
    }
}













