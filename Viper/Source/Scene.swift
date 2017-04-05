//
//  Scene.swift
//  Viper
//
//  Created by Mounir Ybanez on 13/01/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public protocol Scene: class {
    
    func setupArbiter<T: Arbiter>(_ arbiter: T)
}
