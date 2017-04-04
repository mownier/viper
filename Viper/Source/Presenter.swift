//
//  Presenter.swift
//  Viper
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol Presenter: class {

    var scene: ModuleScene! { set get }
    var wireframe: Wireframe! { set get }
    
    associatedtype ModuleScene
}
