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
        let user = User(userID: userId, name: name, tripList: [])
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
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as! Error))
            return
        }

        do {
            let placeData = try Firestore.Encoder().encode(place)
            
            let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
            userRef.updateData(["placeList": FieldValue.arrayUnion([placeData])]) { error in
                if let error = error {
                    completion(.failure(error as! Error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error as! Error))
        }
    }    
    
    func removePlace(movieId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as! Error))
            return
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.updateData(["favoriteMovies": FieldValue.arrayRemove([movieId])]) { error in
            if let error = error {
                completion(.failure(error as! Error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func isPlaceAdded(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as! Error))
            return
        }
        
        let userRef = firestore.collection("user").document(currentUserID)
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error as! Error))
            } else if let document = document, let data = document.data(), let favoriteMovies = data["favoriteMovies"] as? [Int] {
                completion(.success(favoriteMovies.contains(movieId)))
            } else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Não foi possível obter os dados do usuário"]) as! Error))
            }
        }
    }
    
    func getObjectData<T: Codable>(collection: String, forObjectType objectType: T.Type, completion: @escaping (Result<T, Swift.Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as! Error))
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
