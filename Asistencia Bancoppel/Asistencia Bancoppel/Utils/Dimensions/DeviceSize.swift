//
//  DeviceSize.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 21/04/23.
//

import Foundation
import UIKit


enum DeviceSizeEnum {
    case small
    case medium
    case large
    
    func getMultiplier() -> CGFloat {
        switch self {
        case .small:
            return 0.75
        case .medium:
            return 0.85
        case .large:
            return 1
        }
    }
}

class DeviceSize {
    static let size: DeviceSizeEnum = ((UIScreen.main.bounds.height > 812) ? .large : ((UIScreen.main.bounds.height > 667) ? .medium : .small))
}
