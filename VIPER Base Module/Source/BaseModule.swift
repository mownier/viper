//
//  BaseModule.swift
//  VIPER Base Module
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol BaseModule: class {
    
    var presenter: ModulePresenter! { set get }
    var wireframe: ModuleWireframe! { set get }
    var scene: ModuleScene! { set get }
    
    init(scene: ModuleScene)
    
    func viewDidLoad()
    
    associatedtype ModulePresenter
    associatedtype ModuleWireframe
    associatedtype ModuleScene
}

public extension BaseModule {
    
    func viewDidLoad() { }
}

public protocol BaseModuleInteractable: class {
    
    var interactor: ModuleInteractor! { set get }
    
    associatedtype ModuleInteractor
}

public protocol BaseModuleDelegate: class { }

public protocol BaseModuleDelegatable: class {
    
    var delegate: ModuleDelegate? { set get }
    
    associatedtype ModuleDelegate
}

public protocol BaseModuleBuilder: class {
    
    func build(root: RootWireframe?)
}

public protocol BaseModuleInterface: class {
    
    func exit()
}
