//
//  UserPositionModel.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 02/05/23.
//

import Foundation
import UIKit


enum UserPositionEnum: String {
    case backendDev = "Backend Dev"
    case testerQA = "Tester/QA"
    case androidDev = "Android Dev"
    case iosDev = "iOS Dev"
    case scrumMaster = "Scrum Master"
    case businessAnalyst = "Business Analyst"
    case other = "Otro"
    
    func getColor() -> UIColor {
        switch self {
        case .backendDev:
            return GlobalConstants.BancoppelColors.orangeBex3
        case .testerQA:
            return GlobalConstants.BancoppelColors.yellowBex3
        case .androidDev:
            return GlobalConstants.BancoppelColors.greenBex3
        case .iosDev:
            return GlobalConstants.BancoppelColors.blueBex3
        case .scrumMaster:
            return GlobalConstants.BancoppelColors.purpleBex5
        case .businessAnalyst:
            return GlobalConstants.BancoppelColors.pinkBex4
        case .other:
            return GlobalConstants.BancoppelColors.grayBex3
        }
    }
}
