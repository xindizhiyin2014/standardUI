//
//  JKListViewModelProtocol+Extension.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/16.
//

import Foundation
import JKDataHelper_Swift
extension JKListViewModelPartialRefreshProtocol_Swift {
    public var realDatas : [Any] {
        if isPartialRefresh {
            return dataSourceArr
        } else {
            return datas
        }
    }
}

extension JKListViewModelProtocol_Swift {
    
    /// 用于tableView和CollectionView标识section的数量
    public func sectionCount() -> Int {
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            return sectionDatas.count
        }
        return 1
    }
    
    public func itemCount(at section : Int) -> Int {
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section)
             {
                return sectionModel.datas.count
            }
        }
        return realDatas.count
    }
    
    /// 根据indexPath获取Modpublic el
    public func itemViewModel(at item: Int, section: Int) -> Any {
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let model = sectionModel.realDatas.jk_object(index: item) {
                    return model
                }
            }
        } else {
            if let model = realDatas.jk_object(index: item) {
                return model
            }
        }
        
        #if DEBUG
        fatalError("unable to find mode at item:\(item) section:\(section)")
        #else
        return NSObject()
        #endif
    }

    public func headerViewModel(at section: Int) -> Any {
        if let headerModel = config.headerModel {
            return headerModel
        }
        
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                return sectionModel.headerModel as Any
            }
        }
        
        #if DEBUG
        fatalError("unable to find headerViewModel at section:\(section)")
        #else
        return NSObject()
        #endif
    }
    
    public func footerViewModel(at section: Int) -> Any {
        if let headerModel = config.footerModel {
            return headerModel
        }
        
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                return sectionModel.footerModel as Any
            }
        }
        
        #if DEBUG
        fatalError("unable to find headerViewModel at section:\(section)")
        #else
        return NSObject()
        #endif
    }
    
    public func itemViewClass(at item: Int, section: Int) -> AnyClass {
        
        // 配置优先级最高
        if let configCellCls = config.cellClass {
            return configCellCls
        }
        
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let model = sectionModel.realDatas.jk_object(index: item) as? JKReuseViewModelProtocol_Swift {
                    return model.reuseViewClass;
                }
            }
        }
        
        // 单section
        if let itemDatas = realDatas as? [JKReuseViewModelProtocol_Swift] {
            if let model = itemDatas.jk_object(index: item) {
                return model.reuseViewClass;
            }
        }
        
        #if DEBUG
        fatalError("unable to find itemViewClass at item:\(item) section:\(section)")
        #else
        return UIView.self
        #endif
    }
    
    public func headerViewClass(at section: Int) -> AnyClass? {
        
        // 配置优先级最高
        if let configCellCls = config.headerClass {
            return configCellCls
        }
        
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let cls = sectionModel.headerModel?.reuseViewClass {
                    return cls
                }
            }
        }
        return nil
    }
    
    public func footerViewClass(at section: Int) -> AnyClass? {
        
        // 配置优先级最高
        if let configCellCls = config.footerClass {
            return configCellCls
        }
        
        /// 多分区
        if let sectionDatas = realDatas as? [JKSectionViewModelProtocol_Swift] {
            if let sectionModel = sectionDatas.jk_object(index: section) {
                if let cls = sectionModel.footerModel?.reuseViewClass {
                    return cls
                }
            }
        }
        return nil
    }
}
