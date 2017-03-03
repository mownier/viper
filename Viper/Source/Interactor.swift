//
//  Interactor.swift
//  Viper
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol BaseModuleInteractor: class {

    var output: Output? { set get }
    
    associatedtype Output
}

public protocol InteractorInput: class { }

public protocol InteractorOutput: class { }
