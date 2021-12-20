//
//  MultiCellTableViewController.swift
//  rootlib_Example
//
//  Created by chdo002 on 2021/11/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StandardUI
import SnapKit
import JKUIEventHandler_Swift

class MultiCellTableViewController: JKBaseTableViewController_Swift, JKChainEventProtocol {
    
    fileprivate let section1 = DemoSection1()
    fileprivate let section2 = DemoSection2()

    override func cellClasses() -> [AnyClass] {
        return [NormalCell.self,
                BlueCell.self,
                ClickCell.self,
                DemoSection2.ExpendCell.self,
                ObserveCell.self]
    }
    
    override func setUpUI() {
        view.addSubview(tableView)
    }

    override func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }

    override func loadInitData() {
        tableViewModel.datas = [section1, section2]
    }

    // MARK: JKChainEventProtocol
    func jk_receiveChainEvent(eventName: String, data: Any?) -> Bool {
        switch eventName {
        case ClickCell.selectActoin():
            section1.clickAction()
            return false
        case DemoSection2.ExpendCell.selectActoin():
            if #available(iOS 11.0, *) {
                tableView.performBatchUpdates() {
                    tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                }
            } else {
                tableView.reloadData()
            }
            return false
        default:
            return true
        }
    }
}

// MARK: - 页面逻辑

private class DemoSection1 : JKBaseSectionViewModel_Swift {
    
    var sB = NormalCellVM(reuseViewClass: ObserveCell.self)
    
    private var clickCount = 0
    
    override init() {
        super.init()
        initDatas()
    }
    
    func initDatas() {
        let sA = NormalCellVM(reuseViewClass: BlueCell.self)
        sA.name = "例子1 view间联动"

        sB.name = "第二行"
        updataSBName()

        let sC = NormalCellVM(reuseViewClass: ClickCell.self)
        sC.name = "点击这行，修改上面这行的标题"
        datas = [sA, sB, sC]
    }
    
    func clickAction() {
        clickCount += 1
        updataSBName()
    }
    
    func updataSBName(){
        sB.name = "第三行点击数:\(clickCount)"
    }
}

fileprivate class DemoSection2 : JKBaseSectionViewModel_Swift {
    
    class ExpendVM: JKReuseViewModelProtocol_Swift {
        var reuseViewClass: AnyClass = ExpendCell.self
        var name = "点击这行，修改高度"
        var isExpand = false
    }

    class ExpendCell : ClickCell, JKViewModelTypeProtocol{

        typealias ModeType = ExpendVM

        override class func viewHeight(with model: Any?) -> CGFloat {
            guard let vm = model as? ExpendVM else {
                return 0
            }
            if vm.isExpand {
                return 60
            }
            return 30
        }

        override func didSelectView(with model: Any) {
            vm?.isExpand = !vm!.isExpand
            sendChainEvent(eventName: Self.selectActoin(), data: nil)
        }

        override func update(with model: Any) {
            textLabel?.text = vm?.name
        }

        override class func selectActoin() -> String { "ExpendCell_Click" }
    }

    override init() {
        super.init()
        initDatas()
    }
    func initDatas() {
        let sA = NormalCellVM(reuseViewClass: BlueCell.self)
        sA.name = "例子2， 视图高度更新"

        let sB = ExpendVM()
        datas = [sA, sB]
    }
}


// MARK: - 通用准备类

// 通用类型VM
fileprivate struct NormalCellVM: JKReuseViewModelProtocol_Swift {
    var reuseViewClass: AnyClass
    @JKObserve var name: String?
}

// 普通cell
fileprivate class NormalCell: JKBaseTableCell_Swift {
    override func update(with model: Any) {
        if let s = model as? NormalCellVM {
            textLabel?.text = s.name
        }
    }
}

// 蓝色cell
fileprivate class BlueCell: JKBaseTableCell_Swift {
    override func setUpUI() {
        selectionStyle = .none
        textLabel?.textColor = UIColor.systemBlue
    }
    override func update(with model: Any) {
        if let s = model as? NormalCellVM {
            textLabel?.text = s.name
        }
    }
}

// 带点击事件cell
fileprivate class ClickCell: JKBaseTableCell_Swift {
    override func setUpUI() {
        selectionStyle = .none
    }
    override func update(with model: Any) {
        if let s = model as? NormalCellVM {
            textLabel?.text = s.name
        }
    }
    
    override func didSelectView(with model: Any) {
        sendChainEvent(eventName: Self.selectActoin(), data: nil)
    }
    
    class func selectActoin() -> String { "ClickCell_Selected" }
}

// 监听VM cell
fileprivate class ObserveCell: JKBaseTableCell_Swift {
    
    override func update(with model: Any) {
        if let s = model as? NormalCellVM {
            s.$name.observeInitial { [weak self] name in
                self?.textLabel?.text = name
            }
        }
    }
}

