//
//  Box.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import CoreGraphics

public struct Box<F> {
    public var feature = F?.None
    public var frame = CGRect.zero
    public var subboxes = [Box<F>]()
}

public extension Box {
//    func flatten() -> (feature: Feature, frame: CGRect) {
//
//    }
}



