//
//  AccountCreationModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation


struct AccountCreationModel: Codable {
    var assistDay: String?
    var birthDay: String?
    var email: String?
    var employee: Int?
    var lastName1: String?
    var lastName2: String?
    var name: String?
    var phone: String?
    var position: String?
    var profilePhoto: String?
    var team: String?
    
    init(assistDay: String? = nil,
         birthDay: String? = nil,
         email: String? = nil,
         employee: Int? = nil,
         lastName1: String? = nil,
         lastName2: String? = nil,
         name: String? = nil,
         phone: String? = nil,
         position: String? = nil,
         profilePhoto: String? = nil,
         team: String? = nil) {
        self.assistDay = assistDay
        self.birthDay = birthDay
        self.email = email
        self.employee = employee
        self.lastName1 = lastName1
        self.lastName2 = lastName2
        self.name = name
        self.phone = phone
        self.position = position
        self.profilePhoto = profilePhoto
        self.team = team
    }
}
