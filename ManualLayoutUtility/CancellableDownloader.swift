//
//  CancellableDownloader.swift
//  ManualLayoutUtility
//
//  Created by Hoon H. on 2016/07/27.
//  Copyright © 2016 Eonil. All rights reserved.
//

import Foundation

enum CancellableDownloaderResult {
    case ok(NSData)
    case error(ErrorType)
}
final class CancellableDownloader {
    private var context = NSURLSessionTask?.None

    deinit {
        context?.cancel()
    }
    /// This cancels any on-going downloading.
    func download(u: NSURL, completion: (CancellableDownloaderResult) -> ()) {
        context?.cancel()
        context = NSURLSession.sharedSession().downloadTaskWithURL(u, completionHandler: { (u1: NSURL?, _: NSURLResponse?, e: NSError?) in
            func completeWithErrorInMainThread() {
                let e1 = e ?? NSError(domain: NSURLErrorDomain, code: 0, userInfo: [:])
                dispatch_async(dispatch_get_main_queue()) { completion(.error(e1)) }
            }
            func completeWithOKInMainThread(data: NSData) {
                dispatch_async(dispatch_get_main_queue()) { completion(.ok(data)) }
            }
            guard let u1 = u1 else { return completeWithErrorInMainThread() }
            guard let d = NSData(contentsOfURL: u1) else { return completeWithErrorInMainThread() }
            completion(.ok(d))
        })
    }
    func cancel() {
        context?.cancel()
        context = nil
    }
}
