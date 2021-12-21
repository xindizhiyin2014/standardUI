//
//  ListVMProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/13.
//

import UIKit

//MARK: collectionview 配置
public protocol JKCollectionViewModelConfigProtocol_Swift : JKListViewModelConfigProtocol_Swift {
    
    /// collectionView对应的lineSpace
    var lineSpace : CGFloat  { get set }

    /// collectionView对应的interSpace
    var interSpace : CGFloat  { get set }

    /// collectionView对应的sectionInsets
    var sectionInsets : UIEdgeInsets  { get set }

    /// collectionView对应的列数
    var columnNumber : Int { get set }
    
    /// 装饰视图
    var decorateClass: JKReuseViewProtocol_Swift.Type? { get set }
    var showDecorate : Bool { get set }
    var decorateInset: UIEdgeInsets { get set }
}

//MARK: - cellvm : JKItemViewModelProtocol,

//MARK: - sectionvm: JKSectionViewModelProtocol
public protocol JSCollectionSectionViewModelProtocol_Swift: JKSectionViewModelProtocol_Swift {
    /// 装饰视图
    var decorateClass: JKReuseViewProtocol_Swift.Type? { get set }
    var showDecorate : Bool { get set }
    var decorateInset: UIEdgeInsets { get set }
}

//MARK: - Collectionview  vm
public protocol JKCollectionViewModelProtocol_Swift : JKListViewModelProtocol_Swift {
    
    /// 每个section下单元格行间距
    func itemMinLineSpacing(with section : Int) -> CGFloat

    /// 单元格列间距
    func itemMinInterSpacing(with section : Int) -> CGFloat

    /// 获取某个section的缩进
    func sectionInsets(with section : Int) -> UIEdgeInsets

    /// 获取某个section的列数
    func sectionColumnNumber(with section : Int) -> Int
    
    /// 是否展示装饰视图
    func decorateDisplay(in section: Int) -> Bool
    
    /// 某个section的装饰视图类型
    func decorateClass(in section: Int) -> JKReuseViewProtocol_Swift.Type
    
    /// 分区内装饰视图外边距
    func decorateInset(in section: Int) -> UIEdgeInsets
    
}
