//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground
import ManualLayoutUtility

let f = CommonFeature.text(CommonText.plain("AAA"))
let s = Piece(f)
let r = CGRect(x: 0, y: 0, width: 100, height: 100)
let b = s.arrange(in: r)

let v = CommonFeatureRenderingView()
v.wantsLayer = true
v.layer?.backgroundColor = NSColor.redColor().CGColor
v.frame = r
v.render(b)

XCPlaygroundPage.currentPage.liveView = v
