//
//  CommonFeatureRenderingView.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/26.
//  Copyright © 2016 Eonil. All rights reserved.
//

import AppKit

private struct LocalState {
    var box = Box<CommonFeature>()
}

public enum CommonFeatureAction {
    case button(CommonButtonID)
}

/// A view which renders common features statically.
public final class CommonFeatureRenderingView: NSView {
    var dispatch: ((CommonFeatureAction) -> ())?
    private let downloader = CancellableDownloader()
    private var local = LocalState()
    private var featureView = NSView?.None
    private var subboxViews = [NSView]()
    
    public func render(box: Box<CommonFeature>) {
        local.box = box
        renderLocalState()
    }
    private func renderLocalState() {
        do {

        }
        do {
            for i in rangeBetweenIfAvailable(local.box.subboxes.count, subboxViews.count).reverse() {
                subboxViews[i].removeFromSuperview()
                subboxViews.removeAtIndex(i)
            }
        }
        do {
            for i in 0..<min(local.box.subboxes.count, subboxViews.count) {
                let b = local.box.subboxes[i]
                let v = CommonFeatureRenderingView()
                v.render(b)
            }
        }
        do {
            for i in rangeBetweenIfAvailable(subboxViews.count, local.box.subboxes.count) {
                let b = local.box.subboxes[i]
                let v = CommonFeatureRenderingView()
                v.dispatch = { [weak self] in self?.dispatch?($0) }
                v.render(b)
                subboxViews.append(v)
                addSubview(v)
            }
        }
    }

    private func reinstantiateFeatureViewIfNeeded() {
        let fearureViewClass = local.box.feature?.getViewClass()
        if fearureViewClass != view.dynamicType {
            downloader.cancel()
            featureView?.removeFromSuperview()
            featureView = nil
            if let newViewClass = fearureViewClass {
                let newView = newViewClass.init()
                addSubview(newView)
                newView.frame = bounds
                featureView = newView
            }
        }
    }
    private func reconfigureFeatureView() {
        assert(featureView.dynamicType == local.box.feature?.getViewClass())
        typealias EC = ManualLayoutUtilityCriticalErrorCode
        func report(actual: NSView.Type) {
            ManualLayoutUtilityCriticalErrorCode
                .unexpectedCommonFeatureRenderingViewFeatureViewClass(actual)
        }
        guard let f = local.box.feature else { return }
        switch f {
        case .placeholder:
            break
        case .text(let s):
            switch s {
            case .plain(let s):
                guard let v = featureView as? NSTextView else { return report(NSTextView.self) }
                v.string = s

            case .rich(let s):
                guard let v = featureView as? NSTextView else { return report(NSTextView.self) }
                v.textStorage?.setAttributedString(s)
            }
        case .image(let s):
            switch s {
            case .inline(let m):
                guard let v = featureView as? NSImageView else { return report(NSImageView.self) }
                v.image = m

            case .link(let m):
                guard let v = featureView as? NSImageView else { return report(NSImageView.self) }
                v.image = nil
                downloader.download(m, completion: { (r: CancellableDownloaderResult) in
                    switch r {
                    case .ok(let d):
                        v.image = NSImage(data: d)
                    default:
                        break
                    }
                })
            }
//        case .button(let s):
//            MARK_unimplemented()
        }
    }
}
private extension CommonFeatureRenderingView {
    @objc
    private func ManualLayoutUtility_onButtonControl(button: AnyObject) {
        MARK_unimplemented()
    }
}

private func rangeBetweenIfAvailable(a: Int, _ b: Int) -> Range<Int> {
    guard a <= b else { return a..<a }
    return a..<b
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private extension CommonFeature {
    func getViewClass() -> NSView.Type? {
        switch self {
        case .placeholder:  return nil
        case .text(_):      return NSTextView.self
        case .image(_):     return NSImageView.self
//        case .button(_):    return NSButton.self
        }
    }
}
























