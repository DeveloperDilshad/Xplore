//
//  DatabaseServices.swift
//  Xplore
//
//  Created by Dilshad P on 07/05/25.
//

import Foundation
import FirebaseFirestore

struct Place: Codable{
    
    let name: String
    let category: String
    let inageURL: String
    let docID: Int
}

class DatabaseServices {
    
    let database = Firestore.firestore()
    
    func fetchPlaces(completion: @escaping (Result<Place, Error>) -> Void ){
        database.collection("places").order(by: "docID", descending: false).getDocuments { snapshot, error in
            
            if let error = error {
                print("firebase error :\(error.localizedDescription)")
            }
            
            guard let snapshot = snapshot else {
                print("Error loading snapshot")
                return
            }
            
            print(snapshot.documents.first?.data())
        }
    }
}
