//
//  JKBaseCollectionIitemView.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit

open class JKBaseCollectionHeaderFooterView_Swift: UICollectionReusableView, JKCollectionReuseViewProtocol_Swift{
    
    public var model: Any?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            bindUIActions()
            loadInitData()
        }
    }
        
    // MARK: JKBaseCollectionReuseViewProtocol
    open class func kind() -> String {
        return UICollectionView.elementKindSectionHeader
    }
    
    
    //MARK: JKBaseViewProtocol
    public required convenience init(_ config: AnyObject?) {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: JKBaseReuseViewProtocol
    open class func viewHeight(with model : Any?) -> CGFloat { return 0 }
    open class func viewSize(with model : Any?) -> CGSize { return CGSize.zero }
        
    /// 为重用视图添加对应viewModel的监听,禁止开发者主动调用
    open func addReuseVMObservers() {}
    /// 移除重用视图对应viewModel上的监听,禁止开发者主动调用
    open func removeReuseVMObservers() {}
    
    open func jk_autoInit() -> Bool { return true }
    open func setUpUI() {}
    open func setUpConstraints() {}
    open func loadInitData() {}
    open func bindUIActions() {}
    open func addObservers() {}
    open func removeObservers() {}
    open func update(with model: Any) {}
    
}

open class JKBaseCollectionCell_Swift: UICollectionViewCell, JKReuseViewProtocol_Swift, JKReuseViewDelegateProtocol_Swift  {
    
    public var model: Any?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            bindUIActions()
            loadInitData()
        }
    }
    
    // MARK: JKBaseReuseViewDelegateProtocol
    open func didSelectView(with model: Any) {}
    
    
    required convenience public init(_ config: AnyObject?) {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: JKBaseReuseViewProtocol
    open class func viewHeight(with model : Any?) -> CGFloat { return 0 }
    open class func viewSize(with model : Any?) -> CGSize { return CGSize.zero }
        
    /// 为重用视图添加对应viewModel的监听,禁止开发者主动调用
    open func addReuseVMObservers() {}
    /// 移除重用视图对应viewModel上的监听,禁止开发者主动调用
    open func removeReuseVMObservers() {}
    
    open func jk_autoInit() -> Bool { return true }
    open func setUpUI() {}
    open func setUpConstraints() {}
    open func loadInitData() {}
    open func bindUIActions() {}
    open func addObservers() {}
    open func removeObservers() {}
    open func update(with model: Any) {}
    
}
