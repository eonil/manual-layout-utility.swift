//
//  Piece.swift
//  ViewState
//
//  Created by Hoon H. on 2016/07/23.
//
//

import CoreGraphics

public struct Piece<F>: PieceProtocol {
    public typealias Feature = F
    public var feature = F?.None
    //    var proportion = CGFloat(1)
    /// Constrains current piece.
    public var constraints = SizeConstraint(width: LengthConstraint(0, CGFloat.max), height: LengthConstraint(0, CGFloat.max))
    /// Defines how subpieces are laid out.
    public var layout = PieceLayout.stack(.leftToRight)
    //    var padding = PieceEdgeVolumes(0,0,0,0)
    //    var margin = BoxEdgeVolumes(0,0,0,0)
    public var subpieces = [Piece<F>]()

    public init() {
    }
    public init(_ feature: Feature) {
        self.feature = feature
    }
    public init(feature: Feature, constraints: SizeConstraint, layout: PieceLayout, subpieces: [Piece<F>]) {
        self.feature = feature
        self.constraints = constraints
        self.layout = layout
        self.subpieces = subpieces
    }
}

