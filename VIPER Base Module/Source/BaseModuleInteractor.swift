//
//  BaseModuleInteractor.swift
//  VIPER Base Module
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol BaseModuleInteractor: class {

    var output: Output? { set get }
    
    associatedtype Output
}

public protocol BaseModuleInteractorInput: class { }

public protocol BaseModuleInteractorOutput: class { }
