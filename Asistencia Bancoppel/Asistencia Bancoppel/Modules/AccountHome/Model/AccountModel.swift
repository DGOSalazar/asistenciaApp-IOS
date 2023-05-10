//
//  Account.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import Foundation

struct AccountModel: Codable {
    var lastName1: String?
    var lastName2: String?
    var name: String?
    var position: String?
    var profilePhoto: String?
    var email: String?
    var employee: Int?
    var team: String?
    
    init(lastName1: String? = nil,
         lastName2: String? = nil,
         name: String? = nil,
         position: String? = nil,
         profilePhoto: String? = nil,
         email: String? = nil,
         employee: Int? = nil,
         team: String? = nil) {
        self.lastName1 = lastName1
        self.lastName2 = lastName2
        self.name = name
        self.position = position
        self.profilePhoto = profilePhoto
        self.email = email
        self.employee = employee
        self.team = team
    }
}
