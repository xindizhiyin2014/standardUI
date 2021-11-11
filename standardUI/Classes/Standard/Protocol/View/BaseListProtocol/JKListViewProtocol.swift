//
//  JKBaseListViewProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/18.
//

import Foundation

public func reuseViewIdentity(_ cls:AnyClass) -> String {
    return "\(cls.self)_ID"
}

public protocol JKListViewPartRefreshUpdaterProtocol_Swift {
    
    var isListViewUpdating: Bool { get set }
    
    associatedtype ListVMType: JKListViewModelProtocol_Swift
    
    init(_ tableView: UITableView, listVM: ListVMType)
    init(_ collectionView: UICollectionView, listVM: ListVMType)
    
    #warning("补充kvo")
//    func apply(chageModel: jk_rootlib_ios.JKKVOArrayChangeModel,
//               changeInfo: [NSKeyValueChangeKey: Any]?,
//               mode: JKListViewModelPartialRefreshProtocol)
}

public protocol JKListViewPartRefreshProtocol_Swift {
    associatedtype UpdaterTtype: JKListViewPartRefreshUpdaterProtocol_Swift
    var listUpdater: UpdaterTtype { get set }
}

public protocol JKListViewProtocol_Swift: JKViewProtocol_Swift, JKListViewPartRefreshProtocol_Swift {
    
    func cellClasses() -> [AnyClass]
    func reuseViewClasses() -> [AnyClass]
    
    func pullRefresh()
    func loadMore()
}

// MARK: - item (tableview/collection cell)
public protocol JKReuseViewProtocol_Swift: JKViewProtocol_Swift {
    
    static func viewHeight(with model : Any?) -> CGFloat
    static func viewSize(with model : Any?) -> CGSize
    /// 为重用视图添加对应viewModel的监听,禁止开发者主动调用
    func addReuseVMObservers()
    /// 移除重用视图对应viewModel上的监听,禁止开发者主动调用
    func removeReuseVMObservers()
}

// item (UITableViewDelegate/UICollectionViewDelegate)
public protocol JKReuseViewDelegateProtocol_Swift {
    /// item 选中的逻辑，对应tableview/collectionview 的 delegate， didselect At indexPath
    func didSelectView(with model: Any)
    
    //. willdisplay enddisplay....
}

