//
//  JKBaseViewProtocol.swift
//  Nimble
//
//  Created by chdo on 2021/1/16.
//

import Foundation

public protocol JKViewProtocol_Swift:NSObjectProtocol {
    
//    associatedtype InitConfigType
    init(_ config: AnyObject?)
    
    func jk_autoInit() -> Bool
    func setUpUI()
    func setUpConstraints()
    func loadInitData()
    func bindUIActions()
    func addObservers()
    func removeObservers()
    var model: Any? { get set }
    func update(with model: Any)
}


public protocol JKViewModelTypeProtocol : JKViewProtocol_Swift {
    associatedtype ModeType
    var vm: ModeType? { get }
}

public extension JKViewModelTypeProtocol {
    var vm : ModeType? {
        get {
            if let m = model as? ModeType {
                return m
            }
            return nil
        }
        set {
            model = newValue
        }
    }
}

//MARK: container
public protocol JKContainerViewProtocol_Swift: JKViewProtocol_Swift {
    func containerWillAppear(animated: Bool)
    func containerWillDisappear(animated: Bool)
    func containerDidDisappear(animated: Bool)
}


public extension JKViewProtocol_Swift {
    
    func jk_autoInit() -> Bool {
      return true
    }
    func setUpUI() {}
    func setUpConstraints() {}
    func loadInitData() {}
    func bindUIActions() {}
    func addObservers() {}
    func removeObservers() {}
    func update(with model: Any) {}
}


public extension JKContainerViewProtocol_Swift {
    
    func containerWillAppear(animated: Bool) {}
    func containerWillDisappear(animated: Bool) {}
    func containerDidDisappear(animated: Bool) {}
}
