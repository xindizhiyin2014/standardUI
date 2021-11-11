//
//  SimpleTableViewController.swift
//  rootlib_Example
//
//  Created by chdo002 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import standardUI
import SnapKit

class SimpleTableViewController: JKBaseTableViewController_Swift {
    
    class SimpleCell: JKBaseTableCell_Swift {
        
        struct Action {
            var title: String
            var handelr: () -> Void
        }
        
        override func update(with model: Any) {
            if let ac = model as? Action {
                textLabel?.text = ac.title
            }
        }
        
        override func didSelectView(with model: Any) {
            if let ac = model as? Action {
                ac.handelr()
            }
        }
    }
        
    override func setUpUI() {
        title = "root demo"
        view.addSubview(tableView)
    }
    
    override func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func cellClasses() -> [AnyClass] {
        return [SimpleCell.self]
    }
    
    override func loadInitData() {
        self.tableViewModel.datas = [
            SimpleCell.Action(title: "TableView Demo", handelr: {
                self.navigationController?.pushViewController(MultiCellTableViewController(), animated: true)
            }),
            SimpleCell.Action(title: "Collection Demo", handelr: {
                self.navigationController?.pushViewController(MultiCellCollectionController(), animated: true)
            })
        ]
    }
    
    override var tableViewModel: JKBaseTableViewModel_Swift {
        get {
            super.tableViewModel.config.cellClass = SimpleCell.self
            return super.tableViewModel
        }
        set { super.tableViewModel = newValue }
    }
}
