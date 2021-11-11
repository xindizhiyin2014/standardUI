//
//  JKBaseTableViewModelConfig.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/18.
//

import Foundation

public struct JKBaseTableViewModelConfig_Swift : JKListViewModelConfigProtocol_Swift {
    
    public var cellClass: AnyClass?
    
    public var headerClass: AnyClass?
    
    public var footerClass: AnyClass?
    
    public var headerModel: Any?
    
    public var footerModel: Any?
    
    public init(cellClass: AnyClass? = nil,
                headerClass: AnyClass? = nil,
                footerClass: AnyClass? = nil,
                headerModel: Any? = nil,
                footerModel: Any? = nil)
    {
        self.cellClass = cellClass
        self.headerClass = headerClass
        self.footerClass = footerClass
        self.headerModel = headerModel
        self.footerModel = footerModel
    }
}
