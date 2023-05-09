//
//  ProfileCertificationsModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation

struct ProfileCertificationsModel: Codable {
    var email: String?
    var projectInfo: [Certification]?
    
    struct Certification: Codable {
        var certificateName: String?
        var certificateNum: String?
        var emissionDate: String?
        var platformEmitted: String?
        var resourcePdf: String?
    }
}
