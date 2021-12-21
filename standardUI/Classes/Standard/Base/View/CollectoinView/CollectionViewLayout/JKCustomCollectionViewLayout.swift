//
//  JKCustomCollectionViewLayout.swift
//  StandardUI
//
//  Created by 陈栋 on 2021/12/21.
//

import UIKit

class JKCustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    weak var container: JKBaseCollectionContainer_Swift?
    
    init(container: JKBaseCollectionContainer_Swift) {
        self.container = container
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let container = container else { return }
        
        // 单section
        if let _ = container.collectionViewModel.realDatas as? [JKReuseViewModelProtocol_Swift] {
            if !container.collectionViewModel.config.showDecorate {
                return
            } else {
                // ..
            }
        }
        
        /// 多分区
        guard let numberOfSections = self.collectionView?.numberOfSections else { return }
        guard let sectionDatas = container.collectionViewModel.realDatas as? [JSCollectionSectionViewModelProtocol_Swift], sectionDatas.count == numberOfSections else { return }
        
        //分别计算每个section的装饰视图的布局属性
        for section in 0..<numberOfSections {
            
            let sectionVm = sectionDatas[section]
            
            if !sectionVm.showDecorate { continue }
            
            //获取该section下第一个，以及最后一个item的布局属性
            guard let numberOfItems = collectionView?.numberOfItems(inSection: section), numberOfItems > 0,
                let firstItem = layoutAttributesForItem(at:IndexPath(item: 0, section: section)),
                let lastItem = self.layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section)) else {
                    continue
            }

            //获取该section的内边距
            sectionVm.decorateInset
            
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            //计算得到该section实际的尺寸
            if self.scrollDirection == .horizontal {
                sectionFrame.origin.x -= sectionInset.left
                sectionFrame.origin.y = sectionInset.top
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = self.collectionView!.frame.height
            } else {
                sectionFrame.origin.x = sectionInset.left
                sectionFrame.origin.y -= sectionInset.top
                sectionFrame.size.width = self.collectionView!.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }

            
        }
    }
}
