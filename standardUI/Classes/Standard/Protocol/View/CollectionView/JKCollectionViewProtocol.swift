//
//  JKBaseTableViewProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit

/// collectionView中的cell点击发送通知的名字
let JKCollectionViewDidSelectNotification = "JKCollectionViewDidSelectNotification"

//MARK: collectionView header footer
public protocol JKCollectionReuseViewProtocol_Swift: JKReuseViewProtocol_Swift {
    ///< section头视图的kind 类型只能为 UICollectionElementKindSectionHeader 或 UICollectionElementKindSectionFooter
    static func kind() -> String
}

// MARK: collectionView cell 使用 JKBaseReuseViewProtocol
//...

//MARK: collectionView 代理
public protocol JKCollectionDelegatorProtocol_Swift: UICollectionViewDataSource, UICollectionViewDelegate {
    associatedtype ContainerType: JKCollectionContainerProtocol_Swift
    init(_ container: ContainerType)
    /// 是否是容器处理点击事件
    var isContainerHandleSelect:Bool {get set}
    func registerCells()
    func registerReuseViews()
}

//MARK: collectionView 容器
public protocol JKCollectionContainerProtocol_Swift: JKListViewProtocol_Swift{
    var collectionView: UICollectionView { get set }
    var collectionViewLayout: UICollectionViewLayout  { get }
    
    associatedtype ListViewType: JKCollectionViewModelProtocol_Swift
    var collectionViewModel: ListViewType { get set }
    
    associatedtype CollectionDelegatorType: JKCollectionDelegatorProtocol_Swift
    var collectionDelegator: CollectionDelegatorType { get set }
}


public protocol JKCollectionViewContainerDelegate_Swift  {
    func container(collectionView:UICollectionView, didSelect indexPath:IndexPath) -> Void
}
