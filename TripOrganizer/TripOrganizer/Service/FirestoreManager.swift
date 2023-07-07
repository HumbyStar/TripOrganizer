//
//  FirestoreManager.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 05/07/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

fileprivate enum CollectionKeys: String {
    case user = "user"
}


class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let firestore: Firestore
    
    private init() {
        firestore = Firestore.firestore()
    }
    
    func createUser(name: String, email: String, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]) as? Error)
            return
        }
        let user = User(userID: userId, name: name, email: email, placeList: [])
        let userCollection = firestore.collection(CollectionKeys.user.rawValue)
        do {
            try userCollection.document(userId).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error as? Error)
        }
    }
    
    
    func addPlace(place: ObjectPlaces, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as? Error ?? Error.userNotFound(name: "Documento não encontrado")))
            return
        }

        do {
            let placeData = try Firestore.Encoder().encode(place)

            let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
            userRef.updateData(["placeList": FieldValue.arrayUnion([placeData])]) { error in
                if let error = error {
                    completion(.failure(error as? Error ?? Error.fileNotFound(name: "Documento não encontrado")))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error as? Error ?? Error.errorDetail(detail: "Erro")))
        }
    }
    
    
    func addProfileImage(image: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])
            completion(.failure(error as? Error ?? Error.fileNotFound(name: "Usuário não encontrado")))
            return
        }

        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.updateData(["profileImage": image]) { error in
            if let error = error {
                completion(.failure(error as? Error ?? Error.fileNotFound(name: "profileImage not found")))
            } else {
                completion(.success(()))
            }
        }
    }
    

    
    func removePlace(place: ObjectPlaces, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as? Error ?? Error.fileNotFound(name: "Documento não encontrado")))
            return
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.updateData(["placeList": FieldValue.arrayRemove([place])]) { error in
            if let error = error {
                completion(.failure(error as? Error ?? Error.fileNotFound(name: "Documento não encontrado")))
            } else {
                completion(.success(()))
            }
        }
    }
    

    
    func getObjectData<T: Codable>(collection: String, forObjectType objectType: T.Type, completion: @escaping (Result<T, Swift.Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as? Error ?? Error.fileNotFound(name: "Documento não existe")))
            return
        }
        
        firestore.collection(collection).document(currentUserID).getDocument { document, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Documento não existe ou houve um erro"])))
                return
            }
            
            do {
                let object = try document.data(as: T.self)
                completion(.success(object))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
