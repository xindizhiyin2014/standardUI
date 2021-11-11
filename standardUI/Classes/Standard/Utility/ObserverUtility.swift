//
//  Observer.swift
//  rootlib
//
//  Created by chendong on 2021/11/9.
//

import Foundation
import UIKit

open class JKWeakBox<T: AnyObject> {
    weak var value: T?
    init(_ value:T) {
        self.value = value
    }
}

@propertyWrapper
open class JKObserve<T> {
    
    open var wrappedValue : T? {
        didSet {
            handler?(wrappedValue)
        }
    }
    open var projectedValue: JKObserve<T> { self }
    
    open var handler:((T?)->Void)?
    public init() { wrappedValue = nil }
    
    /// 观察属性修改
    /// - Parameter handler: 修改回调
    open func observe(handler: @escaping (T?)->Void ) {
        self.handler = handler
    }
    
    open func observeInitial(handler: @escaping (T?)->Void ) {
        observe(handler: handler)
        handler(wrappedValue)
    }
}

