//
//  UserAttendanceDataModel.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 02/05/23.
//

import Foundation
import UIKit


struct UserAttendanceDataModel {
    var fullname: String
    var position: UserPositionEnum
    var profilePhoto: UIImage
    
    init(fullname: String, position: UserPositionEnum, profilePhoto: UIImage) {
        self.fullname = fullname
        self.position = position
        self.profilePhoto = profilePhoto
    }
}
