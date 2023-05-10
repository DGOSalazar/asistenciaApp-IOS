//
//  AccountMoreDataModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation


struct AccountMoreDataModel: Codable {
    var costCenter: String?
    var email: String?
    var enrollDate: String?
    var managerDirect: String?
    var managerMain: String?
    var project: String?
    var scrumMaster: String?
    
    init(costCenter: String? = nil,
         email: String? = nil,
         enrollDate: String? = nil,
         managerDirect: String? = nil,
         managerMain: String? = nil,
         project: String? = nil,
         scrumMaster: String? = nil) {
        self.costCenter = costCenter
        self.email = email
        self.enrollDate = enrollDate
        self.managerDirect = managerDirect
        self.managerMain = managerMain
        self.project = project
        self.scrumMaster = scrumMaster
    }
    
}
