//
//  JKBaseTableViewModel.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/16.
//

import Foundation

open class JKBaseTableViewModel_Swift : NSObject, JKListViewModelProtocol_Swift {

    open lazy var config: JKBaseTableViewModelConfig_Swift = JKBaseTableViewModelConfig_Swift()
    
    open var hasMore: Bool = false
    
    open var isPartialRefresh: Bool = false
    
    open var dataSourceArr: [Any] = []
    
    open var datas: [Any] = []
}
