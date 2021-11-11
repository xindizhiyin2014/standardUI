//
//  JKBaseListPartUpdater.swift
//  Nimble
//
//  Created by chdo on 2021/1/18.
//

import Foundation

open class JKBaseListPartUpdater_Swift <VMType : JKListViewModelProtocol_Swift> : JKListViewPartRefreshUpdaterProtocol_Swift {
    
    public var isListViewUpdating: Bool = false
    
    var collectionView: UICollectionView?
    var tableView: UITableView?
    var listVM: VMType
    public let operationQ: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 1
        return q
    }()
     
    public required init(_ tableView: UITableView, listVM: VMType) {
        self.listVM = listVM
        self.tableView = tableView
    }
    
    public required init(_ collectionView: UICollectionView, listVM: VMType) {
        self.listVM = listVM
        self.collectionView = collectionView
    }
    
//    public func apply(chageModel: JKKVOArrayChangeModel,
//               changeInfo: [NSKeyValueChangeKey : Any]?,
//               mode: JKListViewModelPartialRefreshProtocol) {
//
//    }
}
