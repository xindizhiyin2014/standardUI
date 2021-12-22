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
    
    private var privateCellClasses:[JKReuseViewProtocol_Swift.Type]
    private var privateRuseViewClasses:[JKReuseViewProtocol_Swift.Type]
    unowned private var containerDelegate:CollectionContainerDelegate
    
    public init(cellClasses:[JKReuseViewProtocol_Swift.Type] = [],
                reuseViewClasses:[JKReuseViewProtocol_Swift.Type] = [],
                layout:UICollectionViewLayout,
                collectionViewModel:JKBaseCollectionViewModel_Swift,
                containerDelegate:CollectionContainerDelegate)
    {
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
        collectionDelegator.registerDecorateViews()
        
        collectionView.delegate = collectionDelegator
        collectionView.dataSource = collectionDelegator
        collectionView.backgroundColor = .clear
        collectionDelegator.isContainerHandleSelect = true
        addObservers()
        bindUIActions()
        loadInitData()
        collectionView.reloadData()
    }
    
    open override func cellClasses() -> [JKReuseViewProtocol_Swift.Type] {
        if !privateCellClasses.isEmpty {
            return privateCellClasses
        }
        return super.cellClasses()
    }
    
    open override func reuseViewClasses() -> [JKReuseViewProtocol_Swift.Type] {
        if !privateRuseViewClasses.isEmpty {
            return privateRuseViewClasses
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
        jk_observeNotification(at: collectionView, notificationName: JKCollectionViewDidSelectNotification) { [weak self] notification  in
            let indexPath:IndexPath = notification.object as! IndexPath
            self?.containerDelegate.container(collectionView: self!.collectionView, didSelect: indexPath)
        }
    }
   
    required public convenience init?(coder: NSCoder) {
        self.init(coder:coder)
    }
    
    required public convenience init(_ config: AnyObject?) {
        self.init(config)
    }
}
