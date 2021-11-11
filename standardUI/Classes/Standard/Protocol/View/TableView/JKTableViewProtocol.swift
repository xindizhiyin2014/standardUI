//
//  JKBaseTableViewProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit

/// tableView的cell点击发送通知的名字
let JKTableViewDidSelectNotification = "JKTableViewDidSelectNotification"

//MARK: tableView header footer
public protocol JKTableHeadeFooterViewProtocol_Swift: JKReuseViewProtocol_Swift {
    /// tableView区头、尾高度
    static func estimateheaderFooterHeight(with model: Any) -> CGFloat
}

//MARK: tableView cell
public protocol JKTableCellProtocol_Swift: JKReuseViewProtocol_Swift {
    /// 单元格的预估高度，根据model动态可变
    static func estimateHeight(with model: Any?) -> CGFloat
}

//MARK: tableView 代理
public protocol JKTableDelegatorProtocol_Swift: UITableViewDataSource, UITableViewDelegate {
    associatedtype ContainerType: JKListViewProtocol_Swift
    init(container: ContainerType)
    /// 是否是容器处理点击事件
    var isContainerHandleSelect:Bool {get set}
    func registerCells()
    func registerReuseViews()
}

//MARK: tableView容器
public protocol JKTableContainerProtocol_Swift: JKListViewProtocol_Swift {
    var tableView: UITableView { get set }
    var tableViewStyle: UITableView.Style { get }
    
    associatedtype ListViewModelType: JKListViewModelProtocol_Swift
    var tableViewModel: ListViewModelType { get set }
    
    associatedtype TableDelegatorType: JKTableDelegatorProtocol_Swift
    var tableDelegator: TableDelegatorType { get set }
}

public protocol JKTableViewContainerDelegate_Swift  {
    func container(tableView:UITableView, didSelect indexPath:IndexPath) -> Void
}
