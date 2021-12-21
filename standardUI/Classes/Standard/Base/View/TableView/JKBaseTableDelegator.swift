//
//  JKBaseTableDelegator.swift
//  jk_bodylib_swift
//
//  Created by chdo on 2021/1/19.
//

import UIKit
import JKNoticationHelper_Swift
open class JKBaseTableDelegator_Swift<ContainerType: JKTableContainerProtocol_Swift>:NSObject, JKTableDelegatorProtocol_Swift,JKFastNotificationProtocol where ContainerType : UIResponder  {
    
    /// 是否是容器处理点击事件
    public var isContainerHandleSelect:Bool = false
    
    //MARK: JKBaseTableDelegatorProtocol
    unowned var container: ContainerType
    public required init(container: ContainerType) {
        self.container = container
    }
    
    public func registerCells() {
        for cls in container.cellClasses() {
            container.tableView.register(cls, forCellReuseIdentifier: cls.reuseViewIdentity)
        }
        container.tableView.register(JKBaseTableCell_Swift.self, forCellReuseIdentifier: JKBaseTableCell_Swift.reuseViewIdentity)
    }
    
    public func registerReuseViews() {
        for cls in container.reuseViewClasses() {
            container.tableView.register(cls, forHeaderFooterViewReuseIdentifier: cls.reuseViewIdentity)
        }
        container.tableView.register(JKBaseTableHeaderFooterView_Swift.self, forHeaderFooterViewReuseIdentifier: JKBaseTableHeaderFooterView_Swift.reuseViewIdentity)
    }
    
    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        container.tableViewModel.sectionCount()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        container.tableViewModel.itemCount(at: section)
    }
    
    // MARK: cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cls = container.tableViewModel.itemViewClass(at: indexPath.row, section: indexPath.section)
        
        let contain = container.cellClasses().contains { $0 == cls }
        if !contain {
            #if DEBUG
            fatalError("\(cls) have not registered yet")
            #else
            return tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier)!
            #endif
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cls.reuseViewIdentity) as? JKBaseTableCell_Swift {
            cell.jk_nextResponder = container
            let model = container.tableViewModel.itemViewModel(at: indexPath.row, section: indexPath.section)
            cell.model = model
            cell.update(with: model)
            return cell
        }
        #if DEBUG
        fatalError("unable to dequeue a \(cls) cell")
        #else
        return tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier)!
        #endif
    }
    
    // MARK: header
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cls = container.tableViewModel.headerViewClass(at: section) {
            if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: cls.reuseViewIdentity) as?  JKBaseTableHeaderFooterView_Swift {
                let model = container.tableViewModel.headerViewModel(at: section)
                view.model = model
                view.update(with: model)
                return view
            }
        }
        
        #if DEBUG
        fatalError("unable to dequeue a \(section) cell")
        #else
        return nil
        #endif
    }
    
    // MARK: footer
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let cls = container.tableViewModel.footerViewClass(at: section) {
            if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: cls.reuseViewIdentity) as?  JKBaseTableHeaderFooterView_Swift {
                let model = container.tableViewModel.footerViewModel(at: section)
                view.model = model
                view.update(with: model)
                return view
            }
        }
        #if DEBUG
        fatalError("unable to dequeue a \(section) cell")
        #else
        return nil
        #endif
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isContainerHandleSelect {
            jk_postNotification(at: tableView, notificationName: JKTableViewDidSelectNotification, object: indexPath, userInfo: nil)
        } else {
            if let itemView = tableView.cellForRow(at: indexPath) as? JKReuseViewDelegateProtocol_Swift {
                let model = container.tableViewModel.itemViewModel(at: indexPath.row, section: indexPath.section)
                itemView.didSelectView(with: model)
            }
        }
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cls = container.tableViewModel.itemViewClass(at: indexPath.row, section: indexPath.section)
        let model = container.tableViewModel.itemViewModel(at: indexPath.row, section: indexPath.section)
        return cls.viewHeight(with: model)
    }
    
    // MARK: header
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let cls = container.tableViewModel.headerViewClass(at: section) {
            let model = container.tableViewModel.headerViewModel(at: section)
            return cls.viewHeight(with: model)
        }
        return 0
    }
    
    // MARK: footer
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let cls = container.tableViewModel.footerViewClass(at: section) {
            let model = container.tableViewModel.footerViewModel(at: section)
            return cls.viewHeight(with: model)
        }
        return 0
    }
    
    // MARK: display
    func addReuseViewModelObservers(_ view: UIView) {
        if let reuseView  = view as? JKReuseViewProtocol_Swift {
            reuseView.addReuseVMObservers()
        }
    }
    func removeReuseViewModelObservers(_ view: UIView) {
        if let reuseView  = view as? JKReuseViewProtocol_Swift {
            reuseView.removeReuseVMObservers()
        }
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        addReuseViewModelObservers(cell)
    }
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        removeReuseViewModelObservers(cell)
    }
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        addReuseViewModelObservers(view)
    }
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        removeReuseViewModelObservers(view)
    }
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        addReuseViewModelObservers(view)
    }
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        removeReuseViewModelObservers(view)
    }
}
