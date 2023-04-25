//
//  LastStepViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 24/04/23.
//

import Foundation
import UIKit


class LastStepViewModel {
    var accountCreationObaservable = CustomObservable<String?>()
    
    
    func registerAccount(accountRequest: AccountCreationModel, credential: String, photo: UIImage) {
        registerAuth(accountRequest: accountRequest, credential: credential, photo: photo)
    }
    
    private func registerAuth(accountRequest: AccountCreationModel, credential: String, photo: UIImage) {
        FirebaseManager.shared.signUp(email: accountRequest.email ?? "",
                                      credential: credential) { [weak self] in
            self?.uploadPhoto(accountRequest: accountRequest, photo: photo)
        } failure: { [weak self] error in
            self?.accountCreationObaservable.value = error
        }
    }
    
    private func uploadPhoto(accountRequest: AccountCreationModel, photo: UIImage) {
        FirebaseManager.shared.uploadPhoto(photo: photo, email: accountRequest.email ?? "") { [weak self] url in
            var newRequest = accountRequest
            newRequest.profilePhoto = url
            self?.saveUserData(accountRequest: newRequest)
        } failure: { [weak self] error in
            self?.accountCreationObaservable.value = error
        }
    }
    
    private func saveUserData(accountRequest: AccountCreationModel) {
        FirebaseManager.shared.saveData(collection: GlobalConstants.Firebase.Collections.usersCollection,
                                        document: accountRequest.email ?? "",
                                        data: accountRequest) { [weak self] in
            self?.accountCreationObaservable.value = nil
        } failure: { [weak self] error in
            self?.accountCreationObaservable.value = error
        }
    }
}
