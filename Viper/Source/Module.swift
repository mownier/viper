//
//  Module.swift
//  Viper
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol Module: class {
    
    var presenter: ModulePresenter! { set get }
    var wireframe: ModuleWireframe! { set get }
    var scene: ModuleScene! { set get }
    
    init(scene: ModuleScene)
    
    func viewDidLoad()
    
    associatedtype ModulePresenter
    associatedtype ModuleWireframe
    associatedtype ModuleScene
}

public protocol Interactable: class {
    
    var interactor: ModuleInteractor! { set get }
    
    associatedtype ModuleInteractor
}

public protocol Delegate: class { }

public protocol Delegatable: class {
    
    var delegate: ModuleDelegate? { set get }
    
    associatedtype ModuleDelegate
}

public protocol Builder: class {
    
    func build(root: RootWireframe?)
}

public protocol Arbiter: class {
    
    func exit()
    func didLoadScene()
}

public extension Arbiter {
    
    func didLoadScene() { }
}
