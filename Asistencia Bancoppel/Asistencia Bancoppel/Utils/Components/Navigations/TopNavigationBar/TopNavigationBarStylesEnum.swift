//
//  TopNavigationBarStylesEnum.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 16/05/23.
//

import Foundation
import UIKit


enum TopNavigationBarStylesEnum {
    case one
    case two
    case three
    
    func getBankIconColor() -> UIColor {
        switch self {
        case .one:
            return UIColor.white
        case .two:
            return GlobalConstants.BancoppelColors.blueBex7
        case .three:
            return GlobalConstants.BancoppelColors.blueBex7
        }
    }
    
    func getBackButtonColor() -> UIColor {
        switch self {
        case .one:
            return UIColor.white
        case .two:
            return GlobalConstants.BancoppelColors.blueBex7
        case .three:
            return GlobalConstants.BancoppelColors.blueBex7
        }
    }
    
    func getTitleColor() -> UIColor {
        switch self {
        case .one:
            return UIColor.white
        case .two:
            return GlobalConstants.BancoppelColors.blueBex7
        case .three:
            return GlobalConstants.BancoppelColors.grayBex10
        }
    }
    
    func getRightButtonColor() -> UIColor {
        switch self {
        case .one:
            return UIColor.white
        case .two:
            return GlobalConstants.BancoppelColors.grayBex10
        case .three:
            return GlobalConstants.BancoppelColors.blueBex7
        }
    }
}
