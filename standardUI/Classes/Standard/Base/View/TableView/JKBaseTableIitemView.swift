//
//  JKBaseTableCell.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/16.
//

import UIKit

open class JKBaseTableHeaderFooterView_Swift : UITableViewHeaderFooterView, JKTableHeadeFooterViewProtocol_Swift {
    
    public override init(reuseIdentifier: String?)
    {
        super.init(reuseIdentifier: reuseIdentifier)
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            bindUIActions()
            loadInitData()
        }
    }
    
    // MARK: JKBaseItemViewVMProtocol
    public var model: Any?
    
    // MARK: JKBaseTableHeadeFooterViewProtocol
    open class func estimateheaderFooterHeight(with model: Any) -> CGFloat {
        viewHeight(with: model)
    }
    
    // MARK: JKBaseReuseViewProtocol
   open class func viewHeight(with model : Any?) -> CGFloat {
        return 0
    }
    open class func viewSize(with model : Any?) -> CGSize {
        return CGSize.zero
    }
        
    /// 为重用视图添加对应viewModel的监听,禁止开发者主动调用
    open func addReuseVMObservers() {}
    /// 移除重用视图对应viewModel上的监听,禁止开发者主动调用
    open func removeReuseVMObservers() {}
    
    //MARK: JKBaseViewProtocol
    public required convenience init(_ config: AnyObject?) {
        self.init(reuseIdentifier: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func jk_autoInit() -> Bool { return true }
    open func setUpUI() {}
    open func setUpConstraints() {}
    open func loadInitData() {}
    open func bindUIActions() {}
    open func addObservers() {}
    open func removeObservers() {}
    open func update(with model: Any) {}
    
}

open class JKBaseTableCell_Swift : UITableViewCell, JKTableCellProtocol_Swift, JKReuseViewDelegateProtocol_Swift {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            bindUIActions()
            loadInitData()
        }
    }
    
    // MARK: JKBaseReuseViewDelegateProtocol
    open func didSelectView(with model: Any) {}
    
    // MARK: JKBaseItemViewVMProtocol
    public var model: Any?
    
    // MARK: JKBaseTableHeadeFooterViewProtocol
    open class func estimateHeight(with model: Any?) -> CGFloat {
        viewHeight(with: model)
    }
        
    // MARK: JKBaseReuseViewProtocol
    open class func viewHeight(with model : Any?) -> CGFloat { return UITableView.automaticDimension }
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
    
    // MARK: JKBaseViewProtocol
    required public convenience init( _ config: AnyObject?) {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
