//
//  CustomCalendarCellStyleEnum.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation
import UIKit


internal enum CustomCalendarCellStyleEnum {
    case disabled
    case current
    case enabled
    case unavailable
    
    func getBackgroundColor() -> UIColor {
        switch self {
        case .disabled:
            return GlobalConstants.BancoppelColors.grayBex4
        case .current:
            return GlobalConstants.BancoppelColors.blueBex5
        case .enabled:
            return UIColor.white
        case .unavailable:
            return UIColor.white
        }
    }
    
    func getFontColor() -> UIColor {
        switch self {
        case .disabled:
            return GlobalConstants.BancoppelColors.grayBex5
        case .current:
            return GlobalConstants.BancoppelColors.grayBex10
        case .enabled:
            return GlobalConstants.BancoppelColors.grayBex10
        case .unavailable:
            return GlobalConstants.BancoppelColors.grayBex4
        }
    }
}
