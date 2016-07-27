//
//  PieceMakerUtility.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

import XCTest
@testable import ManualLayoutUtility

func makeStackPiece<F>(flow: StackFlowDirection, _ subpieces: [Piece<F>]) -> Piece<F> {
    var p = Piece<F>()
    p.layout = .stack(flow)
    p.subpieces = subpieces
    return p
}
func makeFixedSizedPiece<F>(feature: F, _ size: CGSize) -> Piece<F> {
    return Piece<F>(feature: feature,
                    constraints: SizeConstraint((size.width, size.width), (size.height, size.height)),
                    layout: PieceLayout.over,
                    subpieces: [])
}
func makeFlexibleSizedPiece<F>(feature: F, _ min: CGSize, _ max: CGSize) -> Piece<F> {
    return Piece<F>(feature: feature,
                    constraints: SizeConstraint((min.width, max.width), (min.height, max.height)),
                    layout: PieceLayout.over,
                    subpieces: [])
}
func makePlaceholderPiece(size: CGSize) -> Piece<CommonFeature> {
    return Piece<CommonFeature>(feature: .placeholder,
                                constraints: SizeConstraint((size.width, size.width), (size.height, size.height)),
                                layout: PieceLayout.over,
                                subpieces: [])
}






