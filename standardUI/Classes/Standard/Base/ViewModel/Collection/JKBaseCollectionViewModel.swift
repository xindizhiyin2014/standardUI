//
//  JKBaseCollectionViewModel.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit
import JKDataHelper_Swift
open class JKBaseCollectionViewModel_Swift: NSObject, JKCollectionViewModelProtocol_Swift {
    
    open lazy var config: JKBaseCollectionViewModelConfig_Swift = JKBaseCollectionViewModelConfig_Swift()
    
    open var hasMore: Bool = false
    
    open var isPartialRefresh: Bool = false
    
    open var dataSourceArr: [Any] = []
    
    open var datas: [Any] = []
    
    open func itemMinLineSpacing(with section: Int) -> CGFloat {
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let space = sectionModel.minimumLineSpacing {
                    return space
                }
            }
        }
        return config.lineSpace
    }
    
    open func itemMinInterSpacing(with section: Int) -> CGFloat {
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let space = sectionModel.minimumInteritemSpacing {
                    return space
                }
            }
        }
        return config.interSpace
    }
    
    open func sectionInsets(with section: Int) -> UIEdgeInsets {
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let inset = sectionModel.sectionInsets {
                    return inset
                }
            }
        }
        return config.sectionInsets
    }
    
    open func sectionColumnNumber(with section: Int) -> Int {
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                return sectionModel.columnNumber
            }
        }
        return config.columnNumber
    }
    public override init() {
        super.init()
    }
}
