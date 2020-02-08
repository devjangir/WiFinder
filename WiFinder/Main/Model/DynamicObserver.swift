//
//  DynamicObserver.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 28/01/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import Foundation
typealias CompletionHandler = (() -> Void)

class DynamicObserver<T> {
    //notify all the observers when value is set
    var value : T {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}
