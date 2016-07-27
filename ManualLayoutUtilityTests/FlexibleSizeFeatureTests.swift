//
//  FlexibleSizeFeatureTests.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/24.
//  Copyright © 2016 Eonil. All rights reserved.
//

import XCTest
@testable import ManualLayoutUtility

class FlexibleSizeFeatureTests: XCTestCase {
    func testHappyCase2() {
        enum F1: Measurable {
            case f100
            case f300
            func sizeThatFits(budget: CGSize) -> CGSize {
                switch self {
                case .f100: return CGSize(width: 100, height: 100)
                case .f300: return CGSize(width: 300, height: 100)
                }
            }
        }
        let a = makeFixedSizedPiece(F1.f100, CGSize(width: 100, height: 100))
        let b = makeFlexibleSizedPiece(F1.f300, CGSize(width: 100, height: 100), CGSize(width: 1000, height: 100))
        let c = makeFixedSizedPiece(F1.f100, CGSize(width: 100, height: 100))
        let d = makeStackPiece(.leftToRight, [a, b, c])
        let budget = CGRect(x: 0, y: 0, width: 500, height: 100)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 000, y: 0, width: 100, height: 100), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 100, y: 0, width: 300, height: 100), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 400, y: 0, width: 100, height: 100), "\(c1)")
    }
    func testHappyCase3() {
        enum F1: Measurable {
            case f100
            case f300
            func sizeThatFits(budget: CGSize) -> CGSize {
                switch self {
                case .f100: return CGSize(width: 100, height: 300)
                case .f300: return CGSize(width: 300, height: 100)
                }
            }
        }
        let a = makeFixedSizedPiece(F1.f100, CGSize(width: 100, height: 100))
        let b = makeFlexibleSizedPiece(F1.f300, CGSize(width: 100, height: 100), CGSize(width: 1000, height: 100))
        let c = makeFixedSizedPiece(F1.f100, CGSize(width: 100, height: 100))
        let d = makeStackPiece(.leftToRight, [a, b, c])
        let budget = CGRect(x: 0, y: 0, width: 700, height: 100)
        let box = d.arrange(in: budget)
        XCTAssert(box.frame == budget)
        let a1 = box.subboxes[0]
        let b1 = box.subboxes[1]
        let c1 = box.subboxes[2]
        XCTAssert(a1.frame == CGRect(x: 100, y: 0, width: 100, height: 100), "\(a1)")
        XCTAssert(b1.frame == CGRect(x: 200, y: 0, width: 300, height: 100), "\(b1)")
        XCTAssert(c1.frame == CGRect(x: 500, y: 0, width: 100, height: 100), "\(c1)")
    }
}



















