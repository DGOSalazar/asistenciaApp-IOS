//
//  UserAttendanceDataModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 02/05/23.
//

import Foundation
import UIKit


struct UserAttendanceDataModel {
    var name: String
    var fullname: String
    var email: String
    var position: UserPositionEnum
    var profilePhotoURL: String
    var profilePhoto: UIImage?
    
    init(name: String, fullname: String, email: String, position: UserPositionEnum, profilePhotoURL: String, profilePhoto: UIImage?) {
        self.name = name
        self.fullname = fullname
        self.email = email
        self.position = position
        self.profilePhotoURL = profilePhotoURL
        self.profilePhoto = profilePhoto
    }
}

extension UserAttendanceDataModel: Equatable {
    static func ==(lhs: UserAttendanceDataModel, rhs: UserAttendanceDataModel) -> Bool {
        return lhs.email == rhs.email
    }
}
 
