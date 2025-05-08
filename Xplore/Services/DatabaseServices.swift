//
//  DatabaseServices.swift
//  Xplore
//
//  Created by Dilshad P on 07/05/25.
//

import Foundation
import FirebaseFirestore

protocol DatabaseServicesProtocol {
    func fetchPlaces(completion: @escaping (Result<[Place], FetchDataError>) -> Void )
}

class DatabaseServices : DatabaseServicesProtocol {
    
    let database = Firestore.firestore()
    
    func fetchPlaces(completion: @escaping (Result<[Place], FetchDataError>) -> Void ){
        database.collection("places").order(by: "docID", descending: false).getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(.NetworkError))
                print("firebase error :\(error.localizedDescription)")
            }
            
            guard let snapshot = snapshot else {
                print("Error loading snapshot")
                completion(.failure(.DataError))
                return
            }
            
            let documents = snapshot.documents
            var places = [Place]()
            for doc in documents {
                
                let data = doc.data()
                let name = data["name"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                let docID = data["docID"] as? Int ?? 0
                
                let place = Place(name: name , category: category , inageURL: imageURL , docID: docID )
                places.append(place)
                
            }
            completion(.success(places))
        }
        
    }
}
