//
//  MultiCellCollectionController.swift
//  rootlib_Example
//
//  Created by chdo002 on 2021/11/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import standardUI
import SnapKit
import JKUIEventHandler_Swift

class MultiCellCollectionController: JKBaseCollectionViewController_Swift, JKChainEventProtocol {

    override func setUpUI() {
        view.addSubview(collectionView)
    }
    
    override func cellClasses() -> [AnyClass] {
        return [CellA.self]
    }
    
    override func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func loadInitData() {
        collectionViewModel.datas = [CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM(), CellVM()]
    }
    
    // MARK: ChainEventProtocol
    func jk_receiveChainEvent(eventName: String, data: Any?) -> Bool {
        return true
    }
    
}

class CellA : JKBaseCollectionCell_Swift {
    override class func viewSize(with model: Any?) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    override func setUpUI() {
        contentView.backgroundColor = .systemBlue
    }
}

struct CellVM : JKReuseViewModelProtocol_Swift {
    var reuseViewClass: AnyClass = CellA.self
}
