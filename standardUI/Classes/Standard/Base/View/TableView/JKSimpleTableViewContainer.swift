//
//  JKSimpleTableViewContainer_Swift.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/10/9.
//

import Foundation
import SnapKit

open class JKSimpleTableViewContainer_Swift<TableContainerDelegate:NSObject&JKTableViewContainerDelegate_Swift>:JKBaseTableViewContainer_Swift {

    private var privateCellClasses:Array<AnyClass>?
    private var privateReuseViewClassess:Array<AnyClass>?
    unowned private var containerDelegate:TableContainerDelegate
    public init(cellClasses:Array<AnyClass>?, reuseviewClasses:Array<AnyClass>?, tableViewStyle:UITableView.Style, tableViewModel:JKBaseTableViewModel_Swift, containerDelegate:TableContainerDelegate) {
        
        self.privateCellClasses = cellClasses
        self.privateReuseViewClassess = reuseviewClasses
        self.containerDelegate = containerDelegate
        super.init(frame:.zero)
        
        self.tableViewStyle = tableViewStyle
        self.tableViewModel = tableViewModel
        
        setUpUI()
        setUpConstraints()
        
        tableDelegator.registerCells()
        tableDelegator.registerReuseViews()
        tableView.delegate = tableDelegator
        tableView.dataSource = tableDelegator
        tableView.backgroundColor = .clear
        tableDelegator.isContainerHandleSelect = true
        addObservers()
        bindUIActions()
        loadInitData()
        tableView.reloadData()
    }
    
    open override func cellClasses() -> [AnyClass] {
        if self.privateCellClasses != nil {
            return self.privateCellClasses!
        }
        return super.cellClasses()
    }
    
    open override func reuseViewClasses() -> [AnyClass] {
        if self.privateReuseViewClassess != nil {
            return self.privateReuseViewClassess!
        }
        return super.reuseViewClasses()
    }
    
    open override func jk_autoInit() -> Bool {
        return false
    }
    
    open override func setUpUI() {
        self.addSubview(tableView)
    }
    open override func setUpConstraints() {
        tableView.snp.makeConstraints { make  in
            make.edges.margins.equalToSuperview()
        }
    }
    
    open override func addObservers() {
        weak var weakSelf = self
        jk_observeNotification(at: tableView, notificationName: JKTableViewDidSelectNotification) { notification  in
            let indexPath:IndexPath = notification.object as! IndexPath
            if weakSelf != nil {
                weakSelf!.containerDelegate.container(tableView: weakSelf!.tableView, didSelect: indexPath)
            }
        }
    }
    
    // MARK: UITableViewDelegate
    required public convenience init?(coder: NSCoder) {
        self.init(coder:coder)
    }
    
    required public convenience init(_ config: AnyObject?) {
        self.init(config)
    }
    
}
