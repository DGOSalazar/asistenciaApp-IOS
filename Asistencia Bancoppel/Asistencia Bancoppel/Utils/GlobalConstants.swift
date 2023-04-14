//
//  GlobalConstants.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit

enum GlobalConstants {
    
    private enum Colors {
        static let grayBex1 = "GrayBex1"
        static let grayBex2 = "GrayBex2"
        static let grayBex3 = "GrayBex3"
        static let grayBex10 = "GrayBex10"
        
        static let blueBex3 = "BlueBex3"
        static let blueBex7 = "BlueBex7"
        
        static let greenBex3 = "GreenBex3"
        
        static let orangeBex3 = "OrangeBex3"
        
        static let pinkBex4 = "PinkBex4"
        
        static let yellowBex3 = "YellowBex3"
        
        static let purpleBex5 = "PurpleBex3"
    }

    enum BancoppelColors {
        static let grayBex1 = UIColor(named: GlobalConstants.Colors.grayBex1) ?? .clear
        static let grayBex2 = UIColor(named: GlobalConstants.Colors.grayBex2) ?? .clear
        static let grayBex3 = UIColor(named: GlobalConstants.Colors.grayBex3) ?? .clear
        static let grayBex10 = UIColor(named: GlobalConstants.Colors.grayBex10) ?? .clear
        
        static let blueBex3 = UIColor(named: GlobalConstants.Colors.blueBex3) ?? .clear
        static let blueBex7 = UIColor(named: GlobalConstants.Colors.blueBex7) ?? .clear
        
        static let greenBex7 = UIColor(named: GlobalConstants.Colors.greenBex3) ?? .clear
        
        static let orangeBex3 = UIColor(named: GlobalConstants.Colors.orangeBex3) ?? .clear
        
        static let pinkBex4 = UIColor(named: GlobalConstants.Colors.pinkBex4) ?? .clear
        
        static let yellowBex3 = UIColor(named: GlobalConstants.Colors.yellowBex3) ?? .clear
        
        static let purpleBex5 = UIColor(named: GlobalConstants.Colors.purpleBex5) ?? .clear
        
        
    }
    
    
    enum Images {
        static let bancoppelWhite = "logo_bancoppel_blanco_gde"
        static let menuLoginWhite = "menu_login_white"
    }
}
