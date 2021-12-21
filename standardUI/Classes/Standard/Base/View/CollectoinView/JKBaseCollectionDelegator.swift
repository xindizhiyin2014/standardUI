//
//  JKBaseCollectionDelegator.swift
//  Aspects
//
//  Created by chdo on 2021/1/20.
//

import UIKit
import JKUIEventHandler_Swift
import JKNoticationHelper_Swift

open class JKBaseCollectionDelegator_Swift<ContainerType: JKCollectionContainerProtocol_Swift>: NSObject, JKCollectionDelegatorProtocol_Swift, UICollectionViewDelegateFlowLayout,JKFastNotificationProtocol where ContainerType : UIResponder {
    
    public var isContainerHandleSelect: Bool = false
    
    //MARK: JKBaseTableDelegatorProtocol
    unowned var container: ContainerType
    public required init(_ container: ContainerType) {
        self.container = container
    }
    
    public func registerCells() {
        for cls in container.cellClasses() {
            container.collectionView.register(cls, forCellWithReuseIdentifier: cls.reuseViewIdentity)

        }
        container.collectionView.register(JKBaseCollectionCell_Swift.self, forCellWithReuseIdentifier: JKBaseCollectionCell_Swift.reuseViewIdentity)
    }
    
    public func registerReuseViews() {
        for cls in container.reuseViewClasses() {
            if let reuseCls = cls as? JKCollectionReuseViewProtocol_Swift.Type {
                container.collectionView.register(cls, forSupplementaryViewOfKind: reuseCls.kind(), withReuseIdentifier:cls.reuseViewIdentity)
            } else {
                #if DEBUG
                fatalError("\(cls) shall comfirm JKCollectionReuseViewProtocol_Swift")
                #endif
            }
        }
        
        container.collectionView.register(JKBaseCollectionHeaderFooterView_Swift.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JKBaseCollectionHeaderFooterView_Swift.reuseViewIdentity)
        container.collectionView.register(JKBaseCollectionHeaderFooterView_Swift.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: JKBaseCollectionHeaderFooterView_Swift.reuseViewIdentity)
    }
    
    public func registerDecorateViews() {
        for cls in container.decorateViewClasses() {
            container.collectionViewLayout.register(cls, forDecorationViewOfKind: cls.reuseViewIdentity)
        }
    }
    
    //MARK: UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        container.collectionViewModel.sectionCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        container.collectionViewModel.itemCount(at: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cls = container.collectionViewModel.itemViewClass(at: indexPath.item, section: indexPath.section)
        
        // chendong 处理未注册时的错误，dequeueReusableCell会抛出oc exception，swift无法catch
        let contain = container.cellClasses().contains { $0 == cls }
        if !contain {
            #if DEBUG
            fatalError("\(cls) have not registered yet")
            #else
            return collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseIdentifier, for: indexPath)
            #endif
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cls.reuseViewIdentity, for: indexPath) as? JKBaseCollectionCell_Swift {
            cell.jk_nextResponder = container
            let model = container.collectionViewModel.itemViewModel(at: indexPath.item, section: indexPath.section)
            cell.model = model
            cell.update(with: model)
            return cell
        }
        #if DEBUG
        fatalError("unable to dequeue a \(cls) cell")
        #else
        return collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseIdentifier, for: indexPath)
        #endif
    }
    
    // MARK: SupplementaryElement
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            if let cls = container.collectionViewModel.headerViewClass(at: indexPath.section) {
                if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cls.reuseViewIdentity, for: indexPath) as? UICollectionReusableView&JKCollectionReuseViewProtocol_Swift {
                    let model = container.collectionViewModel.headerViewModel(at: indexPath.section)
                    view.update(with: model)
                    return view
                }
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if let cls = container.collectionViewModel.footerViewClass(at: indexPath.section) {
                if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cls.reuseViewIdentity, for: indexPath) as? UICollectionReusableView&JKCollectionReuseViewProtocol_Swift {
                    let model = container.collectionViewModel.footerViewModel(at: indexPath.section)
                    view.update(with: model)
                    return view
                }
            }
        }
        
        #if DEBUG
        fatalError("unable to dequeue a \(kind) view at \(indexPath)")
        #else
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: defaultViewReuseIdentifier, for: indexPath)
        #endif
    }
    
    //MARK: UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isContainerHandleSelect {
            jk_postNotification(at: collectionView, notificationName: JKCollectionViewDidSelectNotification, object: indexPath, userInfo: nil)
        } else {
            if let itemView = collectionView.cellForItem(at: indexPath) as? JKReuseViewDelegateProtocol_Swift {
                let model = container.collectionViewModel.itemViewModel(at: indexPath.item, section: indexPath.section)
                itemView.didSelectView(with: model)
            }
        }
        
    }
    
    func addReuseViewModelObservers(_ view: UIView) {
        if let reuseView  = view as? JKReuseViewProtocol_Swift {
            reuseView.addReuseVMObservers()
        }
    }
    func removeReuseViewModelObservers(_ view: UIView) {
        if let reuseView  = view as? JKReuseViewProtocol_Swift {
            reuseView.removeReuseVMObservers()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        addReuseViewModelObservers(cell)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        removeReuseViewModelObservers(cell)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        addReuseViewModelObservers(view)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        removeReuseViewModelObservers(view)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cls = container.collectionViewModel.itemViewClass(at: indexPath.item, section: indexPath.section)
        let model = container.collectionViewModel.itemViewModel(at: indexPath.item, section: indexPath.section)
        return cls.viewSize(with: model)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        container.collectionViewModel.sectionInsets(with: section)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        container.collectionViewModel.itemMinLineSpacing(with: section)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        container.collectionViewModel.itemMinInterSpacing(with: section)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let cls = container.collectionViewModel.headerViewClass(at: section) {
            let model = container.collectionViewModel.headerViewModel(at: section)
            return cls.viewSize(with: model)
        }
        return CGSize.zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let cls = container.collectionViewModel.footerViewClass(at: section) {
            let model = container.collectionViewModel.footerViewModel(at: section)
            return cls.viewSize(with: model)
        }
        return CGSize.zero
    }
    
//    //MARK: JKCollectionCustomLayoutDelegate
//
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, columnNumberAtSection section: Int) -> Int {
//        container.collectionViewModel.sectionColumnNumber(with: section)
//    }
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
//        self.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
//    }
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
//        self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section)
//    }
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        self.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
//    }
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, referenceSizeForFooterInSection section: Int) -> CGSize {
//        self.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section)
//    }
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
//    }
//    public func collectionView(_ collectionView: UICollectionView!, customLayout collectionViewLayout: UICollectionViewLayout!, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
//    }
}
