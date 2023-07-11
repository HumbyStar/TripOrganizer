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
        let user = User(userID: userId, name: name, email: email, trip: [])
        let userCollection = firestore.collection(CollectionKeys.user.rawValue)
        do {
            try userCollection.document(userId).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error as? Error)
        }
    }
    
    
    func addTrip(trip: AddTripModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as? Error ?? Error.userNotFound(name: "Documento não encontrado")))
            return
        }

        do {
            let placeData = try Firestore.Encoder().encode(trip)

            let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
            userRef.updateData(["trip": FieldValue.arrayUnion([placeData])]) { error in
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
    
    
    func addPlace(place: Places, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as? Error ?? Error.userNotFound(name: "Documento não encontrado")))
            return
        }

        do {
            let placeData = try Firestore.Encoder().encode(place)

            let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)

            userRef.getDocument { (snapshot, error) in
                if let error = error {
                    completion(.failure(error as? Error ?? Error.fileNotFound(name: "Documento não encontrado")))
                    return
                }

                guard let snapshot = snapshot, snapshot.exists else {
                    completion(.failure(Error.fileNotFound(name: "Documento não encontrado")))
                    return
                }

                if let userData = snapshot.data(),
                   let trip = userData["trip"] as? [[String: Any]], !trip.isEmpty {
                    
                    var updatedTrips = trip
                    var firstTrip = updatedTrips[0]

                    if var placeList = firstTrip["placeList"] as? [[String: Any]] {
                        placeList.append(placeData)
                        firstTrip["placeList"] = placeList
                    } else {
                        firstTrip["placeList"] = [placeData]
                    }

                    updatedTrips[0] = firstTrip

                    userRef.updateData(["trip": updatedTrips]) { error in
                        if let error = error {
                            completion(.failure(error as? Error ?? Error.fileNotFound(name: "Documento não encontrado")))
                        } else {
                            completion(.success(()))
                        }
                    }
                } else {
                    completion(.failure(Error.fileNotFound(name: "A lista de trips está vazia ou inacessível")))
                }
            }
        } catch let error {
            completion(.failure(error as? Error ?? Error.errorDetail(detail: "Erro")))
        }
    }

    
    func removePlace(place: Places, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"]) as? Error ?? Error.fileNotFound(name: "Documento não encontrado")))
            return
        }

        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error as! Error))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(Error.fileNotFound(name: "Documento não encontrado")))
                return
            }
            
            if var trips = document.data()?["trip"] as? [[String: Any]] {

                for (index, trip) in trips.enumerated() {
                    if var placeList = trip["placeList"] as? [[String: Any]] {

                        if let placeIndex = placeList.firstIndex(where: { $0["name"] as? String == place.name }) {
                            placeList.remove(at: placeIndex)
                            
                            trips[index]["placeList"] = placeList
                            
                            userRef.updateData(["trip": trips]) { error in
                                if let error = error {
                                    completion(.failure(error as! Error))
                                } else {
                                    completion(.success(()))
                                }
                            }
                            
                            return
                        }
                    }
                }
                
                completion(.failure(Error.fileNotFound(name: "Objeto não encontrado na lista")))
            } else {
                completion(.failure(Error.fileNotFound(name: "Lista de viagens 'trip' não encontrada")))
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
}
