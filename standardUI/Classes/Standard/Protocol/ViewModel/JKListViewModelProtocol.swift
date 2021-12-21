//
//  ListVMProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/13.
//

import UIKit

// MARK: - PartialRefreshViewModel
public protocol JKListViewModelPartialRefreshProtocol_Swift {
    
    /// 是否启用局部刷新
    var isPartialRefresh: Bool { get set }

    /// 启用局部刷新时的真实数据源，
    var dataSourceArr : [Any] { get set }
    
    /// 不启用局部刷新时作为真实数据源，否则作为用户使用的数据源，在被修改时同步到真实数据源
    var datas : [Any] { get set }
    
    /// 获取真实数据源的便利方法，在extension中实现
    var realDatas : [Any] { get }
}

// MARK: - Item ViewModel
public protocol JKReuseViewModelProtocol_Swift {
    var reuseViewClass : JKReuseViewProtocol_Swift.Type { get set }
}

// MARK: - Section ViewModel
public protocol JKSectionViewModelProtocol_Swift: JKListViewModelPartialRefreshProtocol_Swift {
    
    /// 分区区头的数据源
    var headerModel : JKReuseViewModelProtocol_Swift? { get set }
    
    /// 分区区尾的数据源
    var footerModel : JKReuseViewModelProtocol_Swift? { get set }
    
    var columnNumber : Int { get }
    var minimumLineSpacing : CGFloat? { get }
    var minimumInteritemSpacing : CGFloat? { get }
    var sectionInsets : UIEdgeInsets? { get }
}
