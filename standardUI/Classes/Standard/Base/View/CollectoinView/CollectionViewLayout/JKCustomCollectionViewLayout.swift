//
//  JKCustomCollectionViewLayout.swift
//  StandardUI
//
//  Created by 陈栋 on 2021/12/21.
//

import UIKit

open class JKCustomCollectionViewLayout<ContainerType: JKCollectionContainerProtocol_Swift>: UICollectionViewFlowLayout {
    
    weak var container: ContainerType?
    
    private var decorationViewAttrs: [Int:UICollectionViewLayoutAttributes] = [:]
    
    public init(container: ContainerType) {
        self.container = container
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepare() {
        super.prepare()
        
        guard let container = container else { return }
        let collectionViewModel = container.collectionViewModel
        
        decorationViewAttrs.removeAll()
        
        let numberOfSections = collectionViewModel.sectionCount()
        
        //  计算section frame
        func decorateViewFrame(at section: Int, decorateInset: UIEdgeInsets) -> CGRect {
            let numberOfItems = container.collectionViewModel.itemCount(at: section)
            guard numberOfItems > 0,
                let firstItem = layoutAttributesForItem(at:IndexPath(item: 0, section: section)),
                let lastItem = layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section)) else {
                    return CGRect.null
            }
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            let sectionInset = container.collectionViewModel.sectionInsets(with: section)
            sectionFrame.origin.x = 0
            sectionFrame.origin.y = 0
            if scrollDirection == .horizontal {
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = container.collectionView.frame.height
            } else {
                sectionFrame.size.width = container.collectionView.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }
            return sectionFrame.inset(by:decorateInset)
        }
        
        // 单section
        if let _ = container.collectionViewModel.realDatas as? [JKReuseViewModelProtocol_Swift] {
            guard numberOfSections == 1 else { return }
            if let decorateViewModel = container.collectionViewModel.config.decorateViewModel {
                // 装饰视图位置
                decorateViewModel.frame = decorateViewFrame(at: 0, decorateInset: decorateViewModel.decorateInset)
                decorateViewModel.zIndex = -1
                decorationViewAttrs[0] = decorateViewModel
                return
            } else {
                return
            }
        }

        /// 多分区
        guard let sectionDatas = collectionViewModel.realDatas as? [JKCollectionSectionViewModelProtocol_Swift], sectionDatas.count == numberOfSections else { return }
        //分别计算每个section的装饰视图的布局属性
        for section in 0..<numberOfSections {
            if !collectionViewModel.decorateDisplay(in: section) { continue }
            guard let decorateViewModel = sectionDatas[section].decorateViewModel else { continue }
            // 装饰视图位置
            decorateViewModel.frame = decorateViewFrame(at: section, decorateInset: decorateViewModel.decorateInset)
            decorateViewModel.zIndex = -1
            decorationViewAttrs[section] = decorateViewModel
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributs = super.layoutAttributesForElements(in: rect)
        attributs?.append(contentsOf: decorationViewAttrs.values.filter({rect.intersects($0.frame)}))
        return attributs
    }
    
    open override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let att = decorationViewAttrs[indexPath.section] {
            return att
        }
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
}
