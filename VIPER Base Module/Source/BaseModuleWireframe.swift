//
//  BaseModuleWireframe.swift
//  VIPER Base Module
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

public protocol RootWireframe: class {
    
    var window: UIWindow! { set get }
}

public enum WireframeStyle {
    
    case push
    case present
    case attach
    case root
    case custom
}

public struct WireframeAttribute {
    
    public var animated: Bool = true
    public var controller: UIViewController?
    public var parent: UIViewController?
    public var completion: (() -> Void)?
}

public protocol BaseModuleWireframe: class {
    
    var root: RootWireframe? { set get }
    var style: WireframeStyle { set get }
    
    func enter(attribute: WireframeAttribute)
    func exit(attribute: WireframeAttribute)
}

public protocol Customizable: class {
    
    func customEnter(attribute: WireframeAttribute)
    func customExit(attribute: WireframeAttribute)
}

public protocol Attachable: class {
    
    func attach(attribute: WireframeAttribute)
    func detach(attribute: WireframeAttribute)
}

public protocol Pushable: class {
    
    func push(attribute: WireframeAttribute)
    func pop(attribute: WireframeAttribute)
}

public protocol Presentable: class {
    
    func present(attribute: WireframeAttribute)
    func dismiss(attribute: WireframeAttribute)
}

public protocol Rootable: class {
    
    func makeRoot(attribute: WireframeAttribute, root: RootWireframe)
}

extension Attachable {
    
    func attach(attribute: WireframeAttribute) {
        guard let controller = attribute.controller,
            let parent = attribute.parent else {
            return
        }
        
        parent.view.addSubview(controller.view)
        parent.addChildViewController(controller)
        controller.didMove(toParentViewController: parent)
    }
    
    func detach(attribute: WireframeAttribute) {
        attribute.controller?.view.removeFromSuperview()
        attribute.controller?.removeFromParentViewController()
        attribute.controller?.didMove(toParentViewController: nil)
    }
}

extension Pushable {
    
    func push(attribute: WireframeAttribute) {
        guard let controller = attribute.controller,
            let parent = attribute.parent,
            let nav = parent.navigationController else {
            return
        }
        
        nav.pushViewController(controller, animated: attribute.animated)
    }
    
    func pop(attribute: WireframeAttribute) {
        let controller = attribute.controller
        let nav = controller?.navigationController
        let _ = nav?.popViewController(animated: attribute.animated)
    }
}

extension Presentable {
    
    func present(attribute: WireframeAttribute) {
        guard let controller = attribute.controller,
            let parent = attribute.parent else {
            return
        }
        
        parent.present(controller,
                       animated: attribute.animated,
                       completion: attribute.completion)
    }
    
    func dismiss(attribute: WireframeAttribute) {
        let controller = attribute.controller
        controller?.dismiss(animated: attribute.animated,
                            completion: attribute.completion)
    }
}

extension Rootable {
    
    func makeRoot(attribute: WireframeAttribute, root: RootWireframe) {
        guard let controller = attribute.controller else {
            return
        }
        
        root.window.rootViewController = controller
    }
}

extension BaseModuleWireframe {
    
    public func enter(attribute: WireframeAttribute) {
        switch style {
            
        case .push where self is Pushable:
            let this = self as! Pushable
            this.push(attribute: attribute)
            
        case .present where self is Presentable:
            let this = self as! Presentable
            this.present(attribute: attribute)
            
        case .attach where self is Attachable:
            let this = self as! Attachable
            this.attach(attribute: attribute)
            
        case .root where root != nil && self is Rootable:
            let this = self as! Rootable
            this.makeRoot(attribute: attribute, root: root!)
        
        case .custom where self is Customizable:
            let this = self as! Customizable
            this.customEnter(attribute: attribute)
            
        default:
            break
        }
    }
    
    public func exit(attribute: WireframeAttribute) {
        switch style {
            
        case .push where self is Pushable:
            let this = self as! Pushable
            this.pop(attribute: attribute)
            
        case .present where self is Presentable:
            let this = self as! Presentable
            this.dismiss(attribute: attribute)
            
        case .attach where self is Attachable:
            let this = self as! Attachable
            this.detach(attribute: attribute)
        
        case .custom where self is Customizable:
            let this = self as! Customizable
            this.customExit(attribute: attribute)
           
        default:
            break
        }
    }
}
