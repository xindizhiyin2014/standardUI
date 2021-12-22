//
//  JKBaseSectionViewModel.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit

open class JKBaseSectionViewModel_Swift: JKSectionViewModelProtocol_Swift {
    
    open var headerModel: JKReuseViewModelProtocol_Swift? = nil
    
    open var footerModel: JKReuseViewModelProtocol_Swift? = nil
    
    open var columnNumber: Int = 0
    
    open var minimumLineSpacing: CGFloat? = nil
    
    open var minimumInteritemSpacing: CGFloat? = nil
    
    open var sectionInsets: UIEdgeInsets? = nil
    
    open var isPartialRefresh: Bool = false
    
    open var dataSourceArr: [Any] = []
    
    open var datas: [Any] = []
    
    public init() {}
}

open class JKBaseCollecttionSectionViewModel_Swift: JKBaseSectionViewModel_Swift, JKCollectionSectionViewModelProtocol_Swift {
    public var decorateViewModel: JKDecorateViewModel? = nil
}
