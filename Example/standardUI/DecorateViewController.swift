//
//  DecorateViewController.swift
//  standardUI_Example
//
//  Created by 陈栋 on 2021/12/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StandardUI

class DecorateViewController: JKBaseCollectionViewController_Swift {

    override var collectionViewLayout: UICollectionViewLayout {
        set {
            self.collectionViewLayout = newValue
        }
        get {
            UICollectionViewFlowLayout()
        }
    }
    
    override func setUpUI() {
        view.addSubview(collectionView)
    }
    
    override func cellClasses() -> [AnyClass] {
        return [CellA.self]
    }
    
    override func setUpConstraints() {
        collectionView.snp.makeConstraints { $0.edges.equalTo(0) }
    }
    
    override func loadInitData() {
        collectionViewModel.datas = [SectionVM(),SectionVM()]
    }
    
    // MARK: ChainEventProtocol
    func jk_receiveChainEvent(eventName: String, data: Any?) -> Bool {
        return true
    }
}

class SectionVM : JKBaseSectionViewModel_Swift {
    
    override var datas: [Any] {
        get {
            [CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM()]
        }
        set {
            self.datas = newValue
        }
    }
}
