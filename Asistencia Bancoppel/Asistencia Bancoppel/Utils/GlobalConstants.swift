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
        static let grayBex4 = "GrayBex4"
        static let grayBex5 = "GrayBex5"
        static let grayBex7 = "GrayBex7"
        static let grayBex10 = "GrayBex10"
        
        static let blueBex3 = "BlueBex3"
        static let blueBex4 = "BlueBex4"
        static let blueBex5 = "BlueBex5"
        static let blueBex7 = "BlueBex7"
        static let blueBex10 = "BlueBex10"
        
        static let greenBex3 = "GreenBex3"
        static let greenBex5 = "GreenBex5"
        
        static let orangeBex3 = "OrangeBex3"
        
        static let pinkBex4 = "PinkBex4"
        
        static let yellowBex3 = "YellowBex3"
        
        static let purpleBex5 = "PurpleBex3"
        
        static let redBex10 = "RedBex10"
    }

    enum BancoppelColors {
        static let grayBex1 = UIColor(named: GlobalConstants.Colors.grayBex1) ?? .clear
        static let grayBex2 = UIColor(named: GlobalConstants.Colors.grayBex2) ?? .clear
        static let grayBex3 = UIColor(named: GlobalConstants.Colors.grayBex3) ?? .clear
        static let grayBex4 = UIColor(named: GlobalConstants.Colors.grayBex4) ?? .clear
        static let grayBex5 = UIColor(named: GlobalConstants.Colors.grayBex5) ?? .clear
        static let grayBex7 = UIColor(named: GlobalConstants.Colors.grayBex7) ?? .clear
        static let grayBex10 = UIColor(named: GlobalConstants.Colors.grayBex10) ?? .clear
        
        static let blueBex3 = UIColor(named: GlobalConstants.Colors.blueBex3) ?? .clear
        static let blueBex4 = UIColor(named: GlobalConstants.Colors.blueBex4) ?? .clear
        static let blueBex5 = UIColor(named: GlobalConstants.Colors.blueBex5) ?? .clear
        static let blueBex7 = UIColor(named: GlobalConstants.Colors.blueBex7) ?? .clear
        static let blueBex10 = UIColor(named: GlobalConstants.Colors.blueBex10) ?? .clear
        
        static let greenBex3 = UIColor(named: GlobalConstants.Colors.greenBex3) ?? .clear
        static let greenBex5 = UIColor(named: GlobalConstants.Colors.greenBex5) ?? .clear
        
        static let orangeBex3 = UIColor(named: GlobalConstants.Colors.orangeBex3) ?? .clear
        
        static let pinkBex4 = UIColor(named: GlobalConstants.Colors.pinkBex4) ?? .clear
        
        static let yellowBex3 = UIColor(named: GlobalConstants.Colors.yellowBex3) ?? .clear
        
        static let purpleBex5 = UIColor(named: GlobalConstants.Colors.purpleBex5) ?? .clear
        
        static let redBex10 = UIColor(named: GlobalConstants.Colors.redBex10) ?? .clear
    }
    
    
    enum Images {
        static let bancoppelWhite = "logo_bancoppel_blanco_gde"
        static let menuLoginWhite = "menu_login_white"
        static let menuDetailCalendar = "boton_menu_black"
    }
    
    
    enum Firebase {
        enum Collections {
            static let teamsCollection = "TeamsCollection"
            static let positionCollection = "PositionCollection"
            static let dayCollection = "DayCollection"
            static let dayConfirmCollection = "DayConfirmCollection"
            static let notifyCollection = "NotifyCollection"
            static let usersCollection = "UsersCollection"
            static let officeLocationCollection = "office-location"
            static let userCertificationsCollection = "UserCertificationsCollection"
            static let userProjectCollection = "UserProjectCollection"
            static let usersCollectionMoreData = "UsersCollectionMoreData"
        }
    }
    
    enum Firestore {
        enum FileType {
            case profilePhoto
            case pdf
            
            func getMimeType() -> String {
                switch self {
                case .profilePhoto:
                    return "image/jpg"
                case .pdf:
                    return "application/pdf"
                }
            }
            
            func getPath() -> String {
                switch self {
                case .profilePhoto:
                    return "profilePhotos/usersPhotos/"
                case .pdf:
                    return "pdfDocs/userPdfCertificate/"
                }
            }
            
        }
    }
}
