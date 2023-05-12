//
//  ConfirmationAlertStyleEnum.swift
//  Asistencia Bancoppel
//
//  Created by 232023M90311890 on 10/05/23.
//

import Foundation
import UIKit


enum ConfirmationAlertStyleEnum {
    case confirm
    case destructive
    
    func getFontColor() -> UIColor {
        switch self {
        case .confirm:
            return GlobalConstants.BancoppelColors.blueBex7
        case .destructive:
            return GlobalConstants.BancoppelColors.redBex10
        }
    }
    
    func getIcon() -> UIImage {
        switch self {
        case .confirm:
            return UIImage(named: "confirm_icon") ?? UIImage()
        case .destructive:
            return UIImage(named: "cancel_icon") ?? UIImage()
        }
    }
}
