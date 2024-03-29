//
//  JKBaseCollectionContainer.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit
import JKNoticationHelper_Swift

open class JKBaseCollectionContainer_Swift: UIView, JKCollectionContainerProtocol_Swift,JKFastNotificationProtocol {
    public var model: Any?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            
            collectionDelegator.registerCells()
            collectionDelegator.registerReuseViews()
            
            collectionView.delegate = collectionDelegator
            collectionView.dataSource = collectionDelegator
            collectionView.backgroundColor = .clear
            addObservers()
            bindUIActions()
            loadInitData()
        }
    }
    
    //MARK: JKBaseCollectionContainerProtocol
    
    open var collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout()
    
    open var collectionViewModel: JKBaseCollectionViewModel_Swift = { JKBaseCollectionViewModel_Swift() }()
    
    open lazy var collectionView: UICollectionView = { UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout) }()
    
    open lazy var collectionDelegator: JKBaseCollectionDelegator_Swift<JKBaseCollectionContainer_Swift> = { JKBaseCollectionDelegator_Swift(self) }()
    
    // MARK: JKBaseListViewProtocol
    
    open lazy var listUpdater: JKBaseListPartUpdater_Swift<JKBaseCollectionViewModel_Swift> = {
        JKBaseListPartUpdater_Swift(self.collectionView, listVM: self.collectionViewModel)
    }()
    

    open func cellClasses() -> [AnyClass] {
        if let configCls = self.collectionViewModel.config.cellClass {
            return [configCls]
        }
        return [AnyClass]()
    }
    
    open func reuseViewClasses() -> [AnyClass] {
        var configCls = [AnyClass]()
        if let cls = self.collectionViewModel.config.headerClass {
            configCls.append(cls)
        }
        if let cls = self.collectionViewModel.config.footerClass {
            configCls.append(cls)
        }
        return configCls
    }
    
    open func addObservers() {
        weak var weakSelf = self
        jk_observeNotification(at: collectionView, notificationName: JKCollectionViewDidSelectNotification) { notification  in
            let indexPath:IndexPath = notification.object as! IndexPath
            if weakSelf != nil {
                weakSelf!.container(collectionView: weakSelf!.collectionView, didSelect: indexPath)
            }
        }
    }
    
    open func pullRefresh() {}
    
    open func loadMore() {}
    
//    MARK: JKCollectionViewContainerDelegate_Swift
    open func container(collectionView:UICollectionView, didSelect indexPath:IndexPath) -> Void {
        
    }
    
    open func jk_autoInit() -> Bool {
      return true
    }
    open func setUpUI() {}
    open func setUpConstraints() {}
    open func loadInitData() {}
    open func bindUIActions() {}
    open func removeObservers() {}
    open func update(with model: Any) {}
    
    // MARK: JKBaseViewProtocol
    required public convenience init(_ config: AnyObject?) {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        removeObservers()
    }
}

extension JKBaseCollectionContainer_Swift: JKContainerViewProtocol_Swift {
    
    // MARK: JKBaseContainerViewProtocol
    open func containerWillAppear(animated: Bool) {
        
    }
    
    open func containerWillDisappear(animated: Bool) {
        
    }
    
    open func containerDidDisappear(animated: Bool) {
        
    }
}
