//
//  PieceLayout.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/24.
//  Copyright © 2016 Eonil. All rights reserved.
//

public enum PieceLayout {
    /// All subpieces will be placed at center.
    case over
    /// Subpieces will be laid out in this axis.
    /// In Z-axis, subpieces will always be stacked in its index order.
    /// Lower index is below. Higher index is above.
    case stack(StackFlowDirection)
//    // There're too many uncertainities with table...
//    // Table is no-go for now. And you can make table-like stuff
//    // by using multiple stacks.
//    case table(PieceTable)
}
