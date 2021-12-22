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

    lazy var _collectionViewLayout = JKCustomCollectionViewLayout(container: self)
    override var collectionViewLayout: UICollectionViewLayout {
        set {}
        get { _collectionViewLayout }
    }
    
    override func setUpUI() {
        view.addSubview(collectionView)
    }
    
    override func cellClasses() -> [JKReuseViewProtocol_Swift.Type] {
        return [CellA.self]
    }
    
    override func decorateViewClasses() -> [JKReuseViewProtocol_Swift.Type] {
        var cls = super.decorateViewClasses()
        cls.append(DecorateVM.decorateClass)
        return cls
    }
    
    override func setUpConstraints() {
        collectionView.snp.makeConstraints { $0.edges.equalTo(0) }
    }
    
    override func loadInitData() {
        let s1 = SectionVM()
        s1.decorateViewModel = DecorateVM.make()
        s1.sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionViewModel.datas = [s1,SectionVM()]
    }
    
    // MARK: ChainEventProtocol
    func jk_receiveChainEvent(eventName: String, data: Any?) -> Bool {
        return true
    }
}

class DecorateSectionVM : JKBaseSectionViewModel_Swift {
    var reuseViewClass: JKReuseViewProtocol_Swift.Type = CellA.self
}

class SectionVM : JKBaseCollecttionSectionViewModel_Swift {
    override var datas: [Any] {
        get {
            Array(repeating: CellVM(), count: 15)
        }
        set {}
    }
}

class DecorateVM: UICollectionViewLayoutAttributes, JKCollectionDecorateViewModelProtocol_Swift {
    static var decorateClass: JKDecorateViewType.Type {
        DecorateV.self
    }
    
    var decorateInset: UIEdgeInsets = .zero
}

class DecorateV: UICollectionReusableView, JKReuseViewProtocol_Swift {
    static func viewHeight(with model: Any?) -> CGFloat {
        1
    }
    
    static func viewSize(with model: Any?) -> CGSize {
        .zero
    }
    
    func addReuseVMObservers() {
        
    }
    
    func removeReuseVMObservers() {
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init(_ config: AnyObject?) {
        super.init(frame: .zero)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var model: Any?
    
}
