//
//  JKSimpleCollectionViewContainer.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/10/9.
//

import Foundation
import SnapKit

open class JKSimpleCollectionViewContainer_Swift<CollectionContainerDelegate:NSObject&JKCollectionViewContainerDelegate_Swift>:JKBaseCollectionContainer_Swift {
    typealias ContainerDelegate = NSObject&JKCollectionViewContainerDelegate_Swift
    private var privateCellClasses:Array<AnyClass>?
    private var privateRuseViewClasses:Array<AnyClass>?
    unowned private var containerDelegate:CollectionContainerDelegate
    public init(cellClasses:Array<AnyClass>?, reuseViewClasses:Array<AnyClass>?, layout:UICollectionViewLayout, collectionViewModel:JKBaseCollectionViewModel_Swift, containerDelegate:CollectionContainerDelegate) {
        self.privateCellClasses = cellClasses
        self.privateRuseViewClasses = reuseViewClasses
        self.containerDelegate = containerDelegate
        super.init(frame: .zero)
        
        self.collectionViewLayout = layout
        self.collectionViewModel = collectionViewModel
        
        setUpUI()
        setUpConstraints()
        
        collectionDelegator.registerCells()
        collectionDelegator.registerReuseViews()
        
        collectionView.delegate = collectionDelegator
        collectionView.dataSource = collectionDelegator
        collectionView.backgroundColor = .clear
        collectionDelegator.isContainerHandleSelect = true
        addObservers()
        bindUIActions()
        loadInitData()
        collectionView.reloadData()
    }
    
    open override func cellClasses() -> [AnyClass] {
        if self.privateCellClasses != nil {
            return self.privateCellClasses!
        }
        return super.cellClasses()
    }
    
    open override func reuseViewClasses() -> [AnyClass] {
        if self.privateRuseViewClasses != nil {
            return self.privateRuseViewClasses!
        }
        return super.reuseViewClasses()
    }
    
    open override func jk_autoInit() -> Bool {
      return false
    }
    open override func setUpUI() {
        self.addSubview(collectionView)
    }
    open override func setUpConstraints() {
        collectionView.snp.makeConstraints { make  in
            make.edges.margins.equalToSuperview()
        }
    }
    
    open override func addObservers() {
        weak var weakSelf = self
        jk_observeNotification(at: collectionView, notificationName: JKCollectionViewDidSelectNotification) { notification  in
            let indexPath:IndexPath = notification.object as! IndexPath
            if weakSelf != nil {
                weakSelf!.containerDelegate.container(collectionView: weakSelf!.collectionView, didSelect: indexPath)
            }
        }
    }
   
    required public convenience init?(coder: NSCoder) {
        self.init(coder:coder)
    }
    
    required public convenience init(_ config: AnyObject?) {
        self.init(config)
    }
}
