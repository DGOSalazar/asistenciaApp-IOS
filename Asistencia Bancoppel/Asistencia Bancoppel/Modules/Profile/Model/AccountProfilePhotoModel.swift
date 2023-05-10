//
//  AccountProfilePhotoModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation


struct AccountProfilePhotoModel: Codable {
    var profilePhoto: String?
    
    init(profilePhoto: String? = nil) {
        self.profilePhoto = profilePhoto
    }
}

