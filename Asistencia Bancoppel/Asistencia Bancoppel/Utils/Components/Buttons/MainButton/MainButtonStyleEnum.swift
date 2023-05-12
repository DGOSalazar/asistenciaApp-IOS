//
//  MainButtonStyleEnum.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 03/05/23.
//

import Foundation
import UIKit


enum MainButtonStyleEnum {
    case primary
    case secondary
    
    func getFont() -> UIFont {
        switch self {
        case .primary:
            return UIFont.robotoBold(ofSize: 22)
        case .secondary:
            return UIFont.robotoBold(ofSize: 18)
        }
    }
    
    func getEnabledFontColor() -> UIColor {
        switch self {
        case .primary:
            return .white
        case .secondary:
            return GlobalConstants.BancoppelColors.blueBex7
        }
    }
    
    func getDisabledFontColor() -> UIColor {
        switch self {
        case .primary:
            return GlobalConstants.BancoppelColors.grayBex10
        case .secondary:
            return GlobalConstants.BancoppelColors.grayBex10
        }
    }
    
    
    func getEnabledBackgroundColor() -> UIColor {
        switch self {
        case .primary:
            return GlobalConstants.BancoppelColors.blueBex7
        case .secondary:
            return UIColor.white
        }
    }
    
    func getDisabledBackgroundColor() -> UIColor {
        switch self {
        case .primary:
            return GlobalConstants.BancoppelColors.grayBex2
        case .secondary:
            return GlobalConstants.BancoppelColors.grayBex2
        }
    }
    
    func getBorderSize() -> CGFloat {
        switch self {
        case .primary:
            return 0.0
        case .secondary:
            return 3.0
        }
    }
    
    func getEnabledBorderColor() -> CGColor {
        switch self {
        case .primary:
            return UIColor.clear.cgColor
        case .secondary:
            return GlobalConstants.BancoppelColors.blueBex7.cgColor
        }
    }
    
    func getDisabledBorderColor() -> CGColor {
        switch self {
        case .primary:
            return UIColor.clear.cgColor
        case .secondary:
            return GlobalConstants.BancoppelColors.grayBex10.cgColor
        }
    }
}
