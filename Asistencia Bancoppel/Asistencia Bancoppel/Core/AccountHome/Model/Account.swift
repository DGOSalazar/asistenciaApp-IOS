//
//  Account.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import Foundation

struct Account {
    let rolType: RolType
    let accountName: String
}

enum RolType: String {
    case TesterQA
    case DevelomentAndroid
    case BussinessAnalyst
    case DevelomentBackend
    case ScrumMaster
    case DevelomentiOS
}
