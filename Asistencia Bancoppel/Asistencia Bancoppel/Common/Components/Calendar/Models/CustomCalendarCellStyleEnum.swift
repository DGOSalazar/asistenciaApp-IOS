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
            return UIColor.lightGray
        case .current:
            return UIColor.systemBlue
        case .enabled:
            return UIColor.white
        case .unavailable:
            return UIColor.white
        }
    }
    
    func getFontColor() -> UIColor {
        switch self {
        case .disabled:
            return UIColor.gray
        case .current:
            return UIColor.black
        case .enabled:
            return UIColor.black
        case .unavailable:
            return UIColor.lightGray
        }
    }
}
