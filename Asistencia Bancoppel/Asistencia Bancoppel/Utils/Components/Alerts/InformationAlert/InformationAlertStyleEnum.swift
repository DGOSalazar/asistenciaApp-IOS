//
//  InformationAlertStyleEnum.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 10/05/23.
//

import Foundation
import UIKit


enum InformationAlertStyleEnum {
    case success
    case update
    
    func getIcon() -> UIImage {
        switch self {
        case .success:
            return UIImage(named: "calendar_success_icon") ?? UIImage()
        case .update:
            return UIImage(named: "calendar_update_icon") ?? UIImage()
        }
    }
}
