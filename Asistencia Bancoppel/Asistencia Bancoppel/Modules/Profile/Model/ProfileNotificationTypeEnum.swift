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
    case attendance
    case dinner
    case profile
    
    func getIcon() -> UIImage? {
        switch self {
        case .time:
            return UIImage(named: "notification_time_icon")
        case .attendance:
            return UIImage(named: "notification_attendance_icon")
        case .dinner:
            return UIImage(named: "notification_dinner_icon")
        case .profile:
            return UIImage(named: "default_profile_fill_icon")
        }
    }
}
