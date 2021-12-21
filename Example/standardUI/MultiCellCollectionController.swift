//
//  MultiCellCollectionController.swift
//  rootlib_Example
//
//  Created by chdo002 on 2021/11/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StandardUI
import SnapKit
import JKUIEventHandler_Swift

class MultiCellCollectionController: JKBaseCollectionViewController_Swift, JKChainEventProtocol {

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
    var title = UILabel()
    override func setUpUI() {
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(title)
    }
    override func setUpConstraints() {
        title.snp.makeConstraints { $0.center.equalTo(contentView)}
    }
    override func update(with model: Any) {
        guard let data = model as? CellVM else { return }
        title.text = data.title
    }
}

struct CellVM : JKReuseViewModelProtocol_Swift {
    var reuseViewClass: JKReuseViewProtocol_Swift.Type = CellA.self
//    var decorateClass: 
    var title = "123"
}
