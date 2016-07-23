//
//  StackFlowDirectionTests_macOS.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

import XCTest
@testable import ManualLayoutUtility

class StackFlowDirectionTests_maxOS: XCTestCase {
    func testMinYToMaxY() {
        let a = makeFixedSizedPiece((), CGSize(width: 100, height: 100))
        let b = makeFixedSizedPiece((), CGSize(width: 100, height: 100))
        let c = makeFixedSizedPiece((), CGSize(width: 100, height: 100))
        let d = makeStackPiece(.bottomToTop, [a, b, c]) // macOS uses Y-up coordination.
        let budget = CGRect(x: 0, y: 0, width: 100, height: 500)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 0, y: 100, width: 100, height: 100), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 0, y: 200, width: 100, height: 100), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 0, y: 300, width: 100, height: 100), "\(c1)")
    }
    func testMaxYToMinY() {
        let a = makeFixedSizedPiece((), CGSize(width: 100, height: 10))
        let b = makeFixedSizedPiece((), CGSize(width: 100, height: 20))
        let c = makeFixedSizedPiece((), CGSize(width: 100, height: 30))
        let d = makeStackPiece(.topToBottom, [a, b, c]) // macOS uses Y-up coordination.
        let budget = CGRect(x: 0, y: 0, width: 100, height: 60)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 0, y: 50, width: 100, height: 10), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 0, y: 30, width: 100, height: 20), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 0, y: 0, width: 100, height: 30), "\(c1)")
    }
}









