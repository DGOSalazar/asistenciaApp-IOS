//
//  CustomObservable.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation


class CustomObservable<T> {
    var observe: ((T?) -> ())? = nil
    
    var value: T? = nil {
        didSet {
            self.observe?(self.value)
        }
    }
    
    init(initialValue: T? = nil) {
        self.value = initialValue
    }
}
