//
//  ProfileNotificationType.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation
import UIKit


enum ProfileNotificationTypeEnum {
    case time
    case check
    case dinner
    case profile
    
    func getIcon() -> UIImage {
        switch self {
        case .time:
            return UIImage()
        case .check:
            return UIImage()
        case .dinner:
            return UIImage()
        case .profile:
            return UIImage()
        }
    }
}
