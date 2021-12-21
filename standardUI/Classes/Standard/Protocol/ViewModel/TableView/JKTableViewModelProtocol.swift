//
//  ListVMProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/13.
//

import Foundation

//MARK: tableView 配置
public protocol JKListViewModelConfigProtocol_Swift {
    
    /// cell类名
    var cellClass : JKReuseViewProtocol_Swift.Type? { get set }
    
    /// 分区区头类名
    var headerClass : JKReuseViewProtocol_Swift.Type? { get set }
    
    /// 分区区尾类名
    var footerClass : JKReuseViewProtocol_Swift.Type? { get set }
    
    /// 分区区头的数据源
    var headerModel : Any? { get set }
    
    /// 分区区尾的数据源
    var footerModel : Any? { get set }
}

//MARK: cellvm : JKItemViewModelProtocol,  sectionvm: JKSectionViewModelProtocol
//...

//MARK: tableview  vm
public protocol JKListViewModelProtocol_Swift : JKListViewModelPartialRefreshProtocol_Swift {
    
    associatedtype ConfigType : JKListViewModelConfigProtocol_Swift
    var config : ConfigType { get }
    
    /// 是否还有更多可上拉刷新
    var hasMore: Bool { get set }
    
    /// 用于tableView和CollectionView标识section的数量
    func sectionCount() -> Int
    
    /// 用于tableView标识每个section中row的数量
    func itemCount(at section: Int) -> Int
    
    /// 根据indexPath获取Model
    func itemViewModel(at item: Int, section: Int) -> Any
    
    /// 获取某个setion对应的重用头视图数据模型
    func headerViewModel(at section: Int) -> Any
    
    /// 获取某个section对应的重用尾视图数据模型
    func footerViewModel(at section: Int) -> Any
    
    /// 根据indexPath获取对应的重用视图的类
    func itemViewClass(at item: Int, section: Int) -> JKReuseViewProtocol_Swift.Type
    
    /// 获取某个section对应的重用头视图类名
    func headerViewClass(at section: Int) -> JKReuseViewProtocol_Swift.Type?
    
    /// 获取某个section对应的重用头视图类名
    func footerViewClass(at section: Int) -> JKReuseViewProtocol_Swift.Type?
    
}
