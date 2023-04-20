//
//  FirebaseManager.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 17/04/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


internal class FirebaseManager {
    internal static let shared = FirebaseManager()
    private var firestore: Firestore?
    
    
    private func configureFirestore() {
        guard let firebase = FirebaseApp.app(), self.firestore == nil else {
            return
        }
        
        let auxFirestore = Firestore.firestore(app: firebase)
        auxFirestore.settings.isPersistenceEnabled = true
        self.firestore = auxFirestore
    }
}


extension FirebaseManager {
    internal func getData<T: Codable>(collection: String,
                                      document: String,
                                      dataType: T.Type,
                                      success: @escaping (_ data: T) -> (),
                                      failure: @escaping (_ error: String) -> ()) {
        self.getData(collection: collection, document: document) { dictionaryData in
            guard let nonNilModel = self.decode(modelType: dataType.self, data: dictionaryData) else {
                failure("Parsing error")
                return
            }
            success(nonNilModel)
        } failure: { error in
            failure(error)
        }
    }
    
    internal func getData(collection: String,
                          document: String,
                          success: @escaping (_ data: [String: Any]) -> (),
                          failure: @escaping (_ error: String) -> ()) {
        self.configureFirestore()
        
        guard let nonNilFirestore = self.firestore else {
            failure("Invalid firestore instance")
            return
        }
        
        guard  !collection.isEmpty, !document.isEmpty else {
            failure("Collection or document empty")
            return
        }
        
        let docReference = nonNilFirestore.collection(collection).document(document)
        docReference.getDocument { document, error in
            guard let nonNilDocument = document, nonNilDocument.exists else {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            
            guard let dictionaryData = nonNilDocument.data(), !dictionaryData.isEmpty else {
                failure("Empty data")
                return
            }
            
            success(dictionaryData)
        }
    }
}


extension FirebaseManager {
    internal func saveData<T: Codable>(collection: String,
                                       document: String,
                                       data: T,
                                       success: @escaping () -> (),
                                       failure: @escaping (_ error: String) -> ()) {
        guard let nonNilData = self.encode(data: data) else {
            failure("Parsing error")
            return
        }
        
        self.saveData(collection: collection, document: document, data: nonNilData, success: success, failure: failure)
    }
    
    internal func saveData(collection: String,
                           document: String,
                           data: [String: Any],
                           success: @escaping () -> (),
                           failure: @escaping (_ error: String) -> ()) {
        self.configureFirestore()
        
        guard let nonNilFirestore = self.firestore else {
            failure("Invalid firestore instance")
            return
        }
        
        guard  !collection.isEmpty, !document.isEmpty else {
            failure("Collection or document empty")
            return
        }
        
        nonNilFirestore.collection(collection).document(document).setData(data) { error in
            guard error == nil else {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            success()
        }
    }
}


extension FirebaseManager {
    internal func signIn(email: String,
                         credential: String,
                         success: @escaping () -> (),
                         failure: @escaping (_ error: String) -> ()) {
        guard  !email.isEmpty, !credential.isEmpty else {
            failure("Email or password empty")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: credential) { authResult, error in
            guard error == nil else {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            success()
        }
    }
    
    internal func signUp(email: String,
                         credential: String,
                         success: @escaping () -> (),
                         failure: @escaping (_ error: String) -> ()) {
        guard  !email.isEmpty, !credential.isEmpty else {
            failure("Email or password empty")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: credential) { authResult, error in
            guard error == nil else {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            success()
        }
    }
}

extension FirebaseManager {
    private func decode<T: Codable>(modelType: T.Type, data: Any) -> T? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) else {
            return nil
        }
        return try? JSONDecoder().decode(modelType, from: jsonData)
    }
    
    private func encode<T: Codable>(data: T) -> [String: Any]? {
        guard let nonNilData = try? JSONEncoder().encode(data) else {
            return nil
        }
        let object = try? JSONSerialization.jsonObject(with: nonNilData, options: [])
        guard let dictionary = object as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}


extension FirebaseManager {
    public func uploadPhoto(photo: UIImage,
                            email: String,
                            success: @escaping (_ url: String) -> (),
                            failure: @escaping (_ error: String) -> ()) {
        
        let path = "profilePhotos/usersPhotos/\(email)"
        
        let storage = Storage.storage().reference()
        guard  let imageData = photo.jpegData(compressionQuality: 1) else {
            return
        }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storage.child(path).putData(imageData, metadata: metaData) { (_, error) in
            if let _ = error {
                failure(error?.localizedDescription ?? "Unknown error")
                return
            }
            storage.child(path).downloadURL { url, error in
                guard let nonNilFullURL = url else{
                    failure(error?.localizedDescription ?? "Unknown Error")
                    return
                }
                
                success(nonNilFullURL.absoluteString)
            }
        }
    }
}
