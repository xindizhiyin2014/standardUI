//
//  JKBaseCollectionViewModelConfig.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit

open class JKBaseCollectionViewModelConfig_Swift: JKCollectionViewModelConfigProtocol_Swift {
    
    open var lineSpace: CGFloat = 0
    
    open var interSpace: CGFloat = 0
    
    open var sectionInsets: UIEdgeInsets = .zero
    
    open var columnNumber: Int = 0
    
    open var cellClass: JKReuseViewProtocol_Swift.Type? = nil
    
    open var headerClass: JKReuseViewProtocol_Swift.Type? = nil
    
    open var footerClass: JKReuseViewProtocol_Swift.Type? = nil
    
    open var headerModel: Any? = nil
    
    open var footerModel: Any? = nil
    /// 装饰视图
    open var decorateViewModel: JKDecorateViewModel? = nil
    
    public init() {}
}
