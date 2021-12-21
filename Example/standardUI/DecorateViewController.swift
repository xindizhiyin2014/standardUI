//
//  DecorateViewController.swift
//  standardUI_Example
//
//  Created by 陈栋 on 2021/12/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StandardUI

class JKCustomLayout: UICollectionViewFlowLayout {
    
}

class DecorateViewController: JKBaseCollectionViewController_Swift {

    override var collectionViewLayout: UICollectionViewLayout {
        set {}
        get {
            UICollectionViewFlowLayout()
        }
    }
    
    override func setUpUI() {
        view.addSubview(collectionView)
    }
    
    override func cellClasses() -> [JKReuseViewProtocol_Swift.Type] {
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

class DecorateSectionVM : JKBaseSectionViewModel_Swift {
    var reuseViewClass: JKReuseViewProtocol_Swift.Type = CellA.self
//    var decorateClass:
    var title = "123"
}

class SectionVM : JKBaseSectionViewModel_Swift {
    
    override var datas: [Any] {
        get {
            Array(repeating: CellVM(), count: 15)
        }
        set {}
    }
}
