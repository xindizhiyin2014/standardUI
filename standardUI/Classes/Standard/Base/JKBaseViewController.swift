//
//  JKBaseViewController_Swift.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/9/28.
//

import UIKit
import JKSandBoxManagerSwift

open class JKBaseViewController_Swift:UIViewController,JKViewProtocol_Swift {
    public var model: Any?
    
    /// 导航栏是否隐藏
    public var navBarHidden:Bool
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        navBarHidden = false
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public required init(_ config: AnyObject?) {
        navBarHidden = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        navBarHidden = false
        super.init(coder: coder)
    }
    
    public var navBgColor:UIColor = UIColor.color(withCSS: "5CA0F0")
    public var navTitleColor:UIColor = .white
    
    open override func viewDidLoad() {
        if navBarHidden == true {
            navigationController?.navigationBar.isHidden = true
        }
        super.viewDidLoad()
        view.backgroundColor = UIColor.color(withCSS: "ECEBE8")
        if navigationController != nil  {
            if navigationController!.viewControllers.count > 1 {
                let image = JKSandBoxManagerSwift.image(podName: "JKBasicProvider_Swift", imageName: "icon_nav_back")
                addNavigationBarItem(title: nil, image: image, isLeft: true)
            }
        }
        resetNavUI()
        if jk_autoInit() {
            setUpUI()
            setUpConstraints()
            addObservers()
            bindUIActions()
            loadInitData()
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navBarHidden, animated: animated)
    }
    
    
    /// 重置导航栏样式
    private func resetNavUI() {
        guard navigationController != nil else {
            return
        }
        var image = UIImage.jk_image(withColor: navBgColor)
        if image == nil {
            image = UIImage()
        }
        navigationController!.navigationBar.setBackgroundImage(image, for: .default)
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:navTitleColor]
    }
    
    
    /// 设置导航栏中间的内容
    /// - Parameter titleView: 导航栏中间的视图
    public func setupNavigationBarTitleView(_ titleView:UIView) {
        navigationItem.titleView = titleView
    }
    
    /// 设置导航栏的左右按钮
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - image: 按钮图标
    ///   - isLeft: 是否是左边按钮
    public func addNavigationBarItem(title:String?, image:UIImage?,isLeft:Bool) {
        guard navigationController != nil else {
            return
        }
        var barItem:UIBarButtonItem?
        let action:Selector = isLeft==true ? #selector(leftItemDidClicked(_:)) : #selector(rightItemDidClicked(_:))
        if title != nil {
            let btn:UIButton = UIButton()
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            btn.setTitleColor(.white, for: .normal)
            btn.setTitleColor(.white, for: .disabled)
            btn.setTitleColor(.white, for: .selected)
            btn.setTitleColor(.white, for: .highlighted)
            btn.sizeToFit()
            btn.addTarget(self, action: action, for: .touchUpInside)
            barItem = UIBarButtonItem(customView: btn)
        } else if image != nil {
            let btn:UIButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
            btn.setImage(image, for: .normal)
            btn.imageEdgeInsets = isLeft==true ? UIEdgeInsets.init(top: 0, left: -20, bottom: 0, right: 0) :UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -20)
            btn.addTarget(self, action: action, for: .touchUpInside)
            btn.sizeToFit()
            barItem = UIBarButtonItem(customView: btn)
        } else {
            return
        }
        
        if isLeft == true {
            navigationItem.leftBarButtonItem = barItem
        } else {
            navigationItem.rightBarButtonItem = barItem
        }
        
        
    }
    
    /// 导航栏左边按钮点击触发事件
    /// - Parameter sender: 按钮
    @objc open func leftItemDidClicked(_ sender: Any!) {
        navigationController?.popViewController(animated: true)
    }
    
    /// 导航栏右边按钮点击触发事件
    /// - Parameter sender: 按钮
    @objc open func rightItemDidClicked(_ sender: Any!) {
        
    }
    
    open func jk_autoInit() -> Bool {
      return true
    }
    open func setUpUI() {}
    open func setUpConstraints() {}
    open func loadInitData() {}
    open func bindUIActions() {}
    open func addObservers() {}
    open func removeObservers() {}
    open func update(with model: Any) {}
    
    
}
