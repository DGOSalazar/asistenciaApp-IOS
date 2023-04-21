//
//  CustomTabButtonShadowStyleEnum.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 21/04/23.
//

import Foundation


enum CustomTabButtonShadowStyleEnum {
    case shadowToTheRight
    case centerShadow
    case shadowToTheLeft
    
    func getShadowOffset() -> CGSize {
        switch self {
        case .shadowToTheRight:
            return CGSize(width: 3, height: 0)
        case .centerShadow:
            return CGSize(width: 0, height: 0)
        case .shadowToTheLeft:
            return CGSize(width: -3, height: 0)
        }
    }
}
