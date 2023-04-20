//
//  LoginModel.swift
//  Asistencia Bancoppel
//
//  Created by Joel Ramirez on 19/04/23.
//


struct LoginResponse: Decodable {
    var token: String
    var timeOut: Double
}
