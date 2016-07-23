//
//  Pipe.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/23.
//  Copyright © 2016 Eonil. All rights reserved.
//

import CoreGraphics

func | <T>(a: T, b: T -> T) -> T {
    return b(a)
}
func atLeast(k: CGFloat) -> (CGFloat) -> (CGFloat) {
    return { Swift.max(k, $0) }
}
func atMost(k: CGFloat) -> (CGFloat) -> (CGFloat) {
    return { Swift.min(k, $0) }
}

func atLeast(k: CGSize) -> (CGSize) -> (CGSize) {
    return { max(k, $0) }
}
func atMost(k: CGSize) -> (CGSize) -> (CGSize) {
    return { min(k, $0) }
}

func and(a: Bool, b: Bool) -> Bool {
    return a && b
}
func or(a: Bool, b: Bool) -> Bool {
    return a || b
}

