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
    
    open var sectionInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    open var columnNumber: Int = 0
    
    open var cellClass: AnyClass? = nil
    
    open var headerClass: AnyClass? = nil
    
    open var footerClass: AnyClass? = nil
    
    open var headerModel: Any? = nil
    
    open var footerModel: Any? = nil
}
