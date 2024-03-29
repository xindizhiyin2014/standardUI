//
//  JKBaseCollectionContainer.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/20.
//

import UIKit
import JKNoticationHelper_Swift

open class JKBaseCollectionViewController_Swift: JKBaseViewController_Swift, JKCollectionContainerProtocol_Swift,JKCollectionViewContainerDelegate_Swift,JKFastNotificationProtocol {

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    open override func viewDidLoad() {
        if jk_autoInit() {
            collectionDelegator.registerCells()
            collectionDelegator.registerReuseViews()
            
            collectionView.delegate = collectionDelegator
            collectionView.dataSource = collectionDelegator
        }
        super.viewDidLoad()
        
    }
    
    //MARK: JKBaseCollectionContainerProtocol
    
    open var collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout()
    
    open var collectionViewModel: JKBaseCollectionViewModel_Swift = { JKBaseCollectionViewModel_Swift() }()
    
    open lazy var collectionView: UICollectionView = { UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout) }()
    
    open lazy var collectionDelegator: JKBaseCollectionDelegator_Swift = { JKBaseCollectionDelegator_Swift(self) }()
    
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
    
    open override func addObservers() {
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
    
    // MARK: JKBaseViewProtocol
    required public init(_ config: AnyObject?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        removeObservers()
    }
}
