//
//  ListVMProtocol.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/13.
//

import UIKit

/// 装饰视图VM
public typealias JKDecorateViewType = UICollectionReusableView & JKReuseViewProtocol_Swift
public protocol JKCollectionDecorateViewModelProtocol_Swift {
    static var decorateClass: JKDecorateViewType.Type { get }
    var decorateInset: UIEdgeInsets { get set }
    static func make() -> Self
}

public extension JKCollectionDecorateViewModelProtocol_Swift where Self: UICollectionViewLayoutAttributes {
    // 使用该初始化方法,不指定下标
    static func make() -> Self {
        self.init(forDecorationViewOfKind: Self.decorateClass.reuseViewIdentity, with: IndexPath(item: 0, section: 0))
    }
}

/// 数据类型必须为UICollectionViewLayoutAttributes，可通过继承该类传递数据到装饰视图
public typealias JKDecorateViewModel = UICollectionViewLayoutAttributes & JKCollectionDecorateViewModelProtocol_Swift

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
    
    /// 装饰视图VM
    var decorateViewModel: JKDecorateViewModel? { get set }
}

//MARK: - cellvm : JKItemViewModelProtocol,
//MARK: - sectionvm: JKSectionViewModelProtocol
public protocol JKCollectionSectionViewModelProtocol_Swift: JKSectionViewModelProtocol_Swift {
    /// 装饰视图
    var decorateViewModel: JKDecorateViewModel? { get set }
}

//MARK: - Collectionview  vm
public protocol JKCollectionViewModelProtocol_Swift : JKListViewModelProtocol_Swift where ConfigType : JKCollectionViewModelConfigProtocol_Swift {
    
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
    func decorateClass(in section: Int) -> JKDecorateViewType.Type?
    
    /// 分区内装饰视图外边距
    func decorateInset(in section: Int) -> UIEdgeInsets
    
}
