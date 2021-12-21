//
//  JKBaseTableViewControllerContainer.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/19.
//

import UIKit
import JKNoticationHelper_Swift

open class JKBaseTableViewController_Swift: JKBaseViewController_Swift, JKTableContainerProtocol_Swift,JKTableViewContainerDelegate_Swift,JKFastNotificationProtocol {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    open override func viewDidLoad() {
        if jk_autoInit() {
            tableDelegator.registerCells()
            tableDelegator.registerReuseViews()
            
            tableView.delegate = tableDelegator
            tableView.dataSource = tableDelegator

        }
        super.viewDidLoad()
        
    }
    
    // MARK: JKBaseTableContainerProtocol
    open var tableViewStyle: UITableView.Style = .plain
    
    open var tableViewModel: JKBaseTableViewModel_Swift = { JKBaseTableViewModel_Swift() }()
    
    open lazy var tableView: UITableView = { UITableView(frame: CGRect.zero, style: self.tableViewStyle) }()
    
    open lazy var tableDelegator: JKBaseTableDelegator_Swift = { return JKBaseTableDelegator_Swift(container: self) }()
    
    // MARK: JKBaseListViewProtocol
    
    open lazy var listUpdater: JKBaseListPartUpdater_Swift<JKBaseTableViewModel_Swift> = { JKBaseListPartUpdater_Swift(self.tableView, listVM: self.tableViewModel) }()
    
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
    open override func addObservers() {
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
    
    
    // MARK: JKBaseViewProtocol
    required public init(_ config: AnyObject?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        removeObservers()
    }
}
