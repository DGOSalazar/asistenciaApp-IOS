//
//  ProfileProjectsModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation
struct ProfileProjectsModel: Codable {
    var email: String?
    var projectInfo: [Project]?
    
    struct Project: Codable {
        var projectName: String?
        var releaseDate: String?
    }
}
