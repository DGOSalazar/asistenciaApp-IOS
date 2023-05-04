//
//  AccountViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 20/04/23.
//

import Foundation
import UIKit

class AccountViewModel {
    var dayAttendanceObservable = CustomObservable<([DayAttendanceModel]?, String?)>()
    var usersObservable = CustomObservable<([UserAttendanceDataModel]?, String?)>()
    
    func getDayAttendance() {
        FirebaseManager.shared.getDocuments(collection: GlobalConstants.Firebase.Collections.dayCollection,
                                            dataType: DayAttendanceModel.self) { [weak self] data in
            self?.dayAttendanceObservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.dayAttendanceObservable.value = (nil, error)
        }
    }
    
    func getUsersData() {
        FirebaseManager.shared.getDocuments(collection: GlobalConstants.Firebase.Collections.usersCollection,
                                            dataType: AccountModel.self) { [weak self] data in
            
            let auxUsers: [UserAttendanceDataModel] = data.compactMap { user in
                var auxFullname = ""
                
                if let auxName = user.name, !auxName.isEmpty  {
                    auxFullname = auxName
                }
                
                if let auxLastname1 = user.lastName1, !auxLastname1.isEmpty  {
                    auxFullname += " \(auxLastname1)"
                }
                
                if let auxLastname2 = user.lastName2, !auxLastname2.isEmpty {
                    auxFullname += " \(auxLastname2)"
                }
                
                return UserAttendanceDataModel(name: user.name ?? "",
                                               fullname: auxFullname,
                                               email: user.email ?? "",
                                               position: UserPositionEnum.getPosition(str: user.position ?? ""),
                                               profilePhotoURL: user.profilePhoto ?? "",
                                               profilePhoto: nil)
            }
            
            self?.usersObservable.value = (auxUsers, nil)
        } failure: { [weak self] error in
            self?.usersObservable.value = (nil, error)
        }
    }
}
