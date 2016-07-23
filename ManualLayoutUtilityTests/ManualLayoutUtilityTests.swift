//
//  ManualLayoutUtilityTests.swift
//  ManualLayoutUtilityTests
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

import XCTest
@testable import ManualLayoutUtility

class ManualLayoutUtilityTests: XCTestCase {
    func testHappy1() {
        let a = makeFixedSizedPiece(111, CGSize(width: 100, height: 100))
        let b = makeFixedSizedPiece(222, CGSize(width: 100, height: 100))
        let c = makeFixedSizedPiece(333, CGSize(width: 100, height: 100))
        let d = makeStackPiece(.leftToRight, [a, b, c])
        let budget = CGRect(x: 0, y: 0, width: 300, height: 100)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 000, y: 0, width: 100, height: 100), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 100, y: 0, width: 100, height: 100), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 200, y: 0, width: 100, height: 100), "\(c1)")
    }
    func testHappy3() {
        let a = makeFixedSizedPiece(111, CGSize(width: 100, height: 100))
        let b = makeFixedSizedPiece(222, CGSize(width: 100, height: 100))
        let c = makeFixedSizedPiece(333, CGSize(width: 100, height: 100))
        let d = makeStackPiece(.leftToRight, [a, b, c])
        let budget = CGRect(x: 0, y: 0, width: 500, height: 100)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 100, y: 0, width: 100, height: 100), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 200, y: 0, width: 100, height: 100), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 300, y: 0, width: 100, height: 100), "\(c1)")
    }
    func testHappy4() {
        let a = makeFixedSizedPiece(111, CGSize(width: 100, height: 10))
        let b = makeFixedSizedPiece(222, CGSize(width: 100, height: 20))
        let c = makeFixedSizedPiece(333, CGSize(width: 100, height: 30))
        let d = makeStackPiece(.leftToRight, [a, b, c])
        let budget = CGRect(x: 0, y: 0, width: 300, height: 100)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 000, y: (100/2) - (10/2), width: 100, height: 10), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 100, y: (100/2) - (20/2), width: 100, height: 20), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 200, y: (100/2) - (30/2), width: 100, height: 30), "\(c1)")
    }
}










