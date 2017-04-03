//
//  Wireframe.swift
//  Viper
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

public protocol RootWireframe: class {
    
    var window: UIWindow! { get }
}

public enum WireframeStyle {
    
    case push
    case present
    case attach
    case root
    case custom
}

public struct WireframeInfo {
    
    public var child: Wireframe?
    public var parent: Wireframe?
    
    public init() {
        child = nil
        parent = nil
    }
}

public protocol Wireframe: class {
    
    var root: RootWireframe? { get }
    var style: WireframeStyle { get }
    var viewController: UIViewController? { get }
    var animated: Bool { get }
    var completion: (() -> Void)? { get }
    
    func willEnter(from parent: Wireframe?)
    func willExit()
    func enter(from parent: Wireframe?)
    func exit()
}

public protocol Customizable: class {
    
    func customEnter(info: WireframeInfo)
    func customExit(info: WireframeInfo)
}

public protocol Attachable: class {
    
    func attach(info: WireframeInfo)
    func detach(info: WireframeInfo)
}

public protocol Pushable: class {
    
    func push(info: WireframeInfo)
    func pop(info: WireframeInfo)
}

public protocol Presentable: class {
    
    func present(info: WireframeInfo)
    func dismiss(info: WireframeInfo)
}

public protocol Rootable: class {
    
    func makeRoot(info: WireframeInfo)
    func unroot(info: WireframeInfo)
}

extension Attachable {
    
    public func attach(info: WireframeInfo) {
        guard let controller = info.child?.viewController,
            let parent = info.parent?.viewController else {
            return
        }
        
        parent.view.addSubview(controller.view)
        parent.addChildViewController(controller)
        controller.didMove(toParentViewController: parent)
    }
    
    public func detach(info: WireframeInfo) {
        info.child?.viewController?.view.removeFromSuperview()
        info.child?.viewController?.removeFromParentViewController()
        info.child?.viewController?.didMove(toParentViewController: nil)
    }
}

extension Pushable {
    
    public func push(info: WireframeInfo) {
        guard let child = info.child,
            let controller = child.viewController,
            let parent = info.parent?.viewController,
            let nav = parent.navigationController else {
            return
        }
        
        nav.pushViewController(controller, animated: child.animated)
    }
    
    public func pop(info: WireframeInfo) {
        guard let child = info.child,
            let nav = child.viewController?.navigationController else {
            return
        }
        
        let _ = nav.popViewController(animated: child.animated)
    }
}

extension Presentable {
    
    public func present(info: WireframeInfo) {
        guard let child = info.child,
            let controller = info.child?.viewController,
            let parent = info.parent?.viewController else {
            return
        }
        
        parent.present(controller, animated: child.animated, completion: child.completion)
    }
    
    public func dismiss(info: WireframeInfo) {
        guard let child = info.child,
            let controller = child.viewController else {
            return
        }
        
        controller.dismiss(animated: child.animated, completion: child.completion)
    }
}

extension Rootable {
    
    public func makeRoot(info: WireframeInfo) {
        guard let controller = info.child?.viewController,
            let root = info.child?.root else {
            return
        }
        
        root.window.rootViewController = controller.navigationController ?? controller
    }
    
    public func unroot(info: WireframeInfo) {
        guard let controller = info.child?.viewController,
            let root = info.child?.root,
            root.window.rootViewController == controller else {
            return
        }
        
        root.window.rootViewController = nil
    }
}

extension Wireframe {
    
    public func willEnter(from parent: Wireframe?) { }
    
    public func willExit() { }
    
    public func enter(from parent: Wireframe?) {
        willEnter(from: parent)
        
        var info = WireframeInfo()
        info.child = self
        info.parent = parent
        
        switch style {
        case .push where self is Pushable:
            let this = self as! Pushable
            this.push(info: info)
            
        case .present where self is Presentable:
            let this = self as! Presentable
            this.present(info: info)
            
        case .attach where self is Attachable:
            let this = self as! Attachable
            this.attach(info: info)
            
        case .root where root != nil && self is Rootable:
            let this = self as! Rootable
            this.makeRoot(info: info)
            
        case .custom where self is Customizable:
            let this = self as! Customizable
            this.customEnter(info: info)
            
        default:
            break
        }
    }
    
    public func exit() {
        willExit()
        
        var info = WireframeInfo()
        info.child = self
        
        switch style {
        case .push where self is Pushable:
            let this = self as! Pushable
            this.pop(info: info)
            
        case .present where self is Presentable:
            let this = self as! Presentable
            this.dismiss(info: info)
            
        case .attach where self is Attachable:
            let this = self as! Attachable
            this.detach(info: info)
            
        case .root where self is Rootable:
            let this = self as! Rootable
            this.unroot(info: info)
            
        case .custom where self is Customizable:
            let this = self as! Customizable
            this.customExit(info: info)
            
        default:
            break
        }
    }
}
