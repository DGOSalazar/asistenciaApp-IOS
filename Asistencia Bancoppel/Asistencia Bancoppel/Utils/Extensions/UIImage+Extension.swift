//
//  UIImage+Extension.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 02/05/23.
//

import Foundation
import UIKit


extension UIImage {
    convenience init?(fromURL: String, completion: ((UIImage) -> ())? = nil) {
        guard let nonNilURL = URL(string: fromURL) else {
            self.init()
            completion?(self)
            return
        }
        
        let responseData = try? Data(contentsOf: nonNilURL)
        
        guard let nonNilData = responseData else {
            self.init()
            completion?(self)
            return
        }
        
        self.init(data: nonNilData)
        completion?(self)
    }
}
