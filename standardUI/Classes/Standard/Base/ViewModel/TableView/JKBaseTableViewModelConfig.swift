//
//  JKBaseTableViewModelConfig.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/18.
//

import Foundation

public struct JKBaseTableViewModelConfig_Swift : JKListViewModelConfigProtocol_Swift {
    
    public var cellClass: JKReuseViewProtocol_Swift.Type?
    
    public var headerClass: JKReuseViewProtocol_Swift.Type?
    
    public var footerClass: JKReuseViewProtocol_Swift.Type?
    
    public var headerModel: Any?
    
    public var footerModel: Any?
    
    public init(cellClass: JKReuseViewProtocol_Swift.Type? = nil,
                headerClass: JKReuseViewProtocol_Swift.Type? = nil,
                footerClass: JKReuseViewProtocol_Swift.Type? = nil,
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
