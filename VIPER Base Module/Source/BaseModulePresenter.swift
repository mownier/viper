//
//  BaseModulePresenter.swift
//  VIPER Base Module
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol BaseModulePresenter: class {

    var scene: ModuleScene! { set get }
    var wireframe: ModuleWireframe! { set get }
    
    associatedtype ModuleScene
    associatedtype ModuleWireframe
}
