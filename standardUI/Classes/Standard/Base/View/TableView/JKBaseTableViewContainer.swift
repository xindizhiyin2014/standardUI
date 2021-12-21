//
//  JKBaseTableViewContainer.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/18.
//

import UIKit
import JKNoticationHelper_Swift

open class JKBaseTableViewContainer_Swift: UIView, JKTableContainerProtocol_Swift,JKTableViewContainerDelegate_Swift,JKFastNotificationProtocol {
    
    public var model: Any?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            
            tableDelegator.registerCells()
            tableDelegator.registerReuseViews()
            
            tableView.delegate = tableDelegator
            tableView.dataSource = tableDelegator
            tableView.backgroundColor = .clear
            addObservers()
            bindUIActions()
            loadInitData()
        }
    }
    // MARK: JKBaseTableContainerProtocol
    public var tableViewStyle: UITableView.Style = .plain
    
    public var tableViewModel: JKBaseTableViewModel_Swift = { JKBaseTableViewModel_Swift() }()
    
    public lazy var tableView: UITableView = { UITableView(frame: .zero, style: self.tableViewStyle) }()
    
    public lazy var tableDelegator: JKBaseTableDelegator_Swift<JKBaseTableViewContainer_Swift> = { JKBaseTableDelegator_Swift(container: self) }()
    
    // MARK: JKBaseListViewProtocol
    
    public lazy var listUpdater: JKBaseListPartUpdater_Swift<JKBaseTableViewModel_Swift> = { JKBaseListPartUpdater_Swift(self.tableView, listVM: self.tableViewModel) }()
    
    open func cellClasses() -> [JKReuseViewProtocol_Swift.Type] {
        if let configCls = self.tableViewModel.config.cellClass {
            return [configCls]
        }
        return []
    }
    
    open func reuseViewClasses() -> [JKReuseViewProtocol_Swift.Type] {
        var configCls = [JKReuseViewProtocol_Swift.Type]()
        if let cls = self.tableViewModel.config.headerClass {
            configCls.append(cls)
        }
        if let cls = self.tableViewModel.config.footerClass {
            configCls.append(cls)
        }
        return configCls
    }
    
    open func addObservers() {
        jk_observeNotification(at: tableView, notificationName: JKTableViewDidSelectNotification) { [weak self] notification  in
            let indexPath:IndexPath = notification.object as! IndexPath
            self?.container(tableView: self!.tableView, didSelect: indexPath)
        }
    }
    
    
    public func pullRefresh() {}
    
    public func loadMore() {}
    
    //MARK:JKTableViewContainerDelegate_Swift
    open func container(tableView:UITableView, didSelect indexPath:IndexPath) -> Void {
        
    }
    
    open func jk_autoInit() -> Bool {
      return true
    }
    open func setUpUI() {}
    open func setUpConstraints() {}
    open func loadInitData() {}
    open func bindUIActions() {}
    open func removeObservers() {}
    open func update(with model: Any) {}
    
    // MARK: JKBaseViewProtocol
    required public convenience init(_ config: AnyObject?) {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    deinit {
        removeObservers()
    }
}
