//
//  DatabaseServices.swift
//  Xplore
//
//  Created by Dilshad P on 07/05/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol DatabaseServicesProtocol {
    func fetchPlaces(completion: @escaping (Result<[Place], FetchDataError>) -> Void )
    func fetchUserData(completion:@escaping(Result<User,FirestoreError>) -> Void)
}

class DatabaseServices : DatabaseServicesProtocol {
    
    let database = Firestore.firestore()
    let user = Auth.auth().currentUser
    
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
                let placeID = data["placeID"] as? String ?? ""
                
                let place = Place(name: name , category: category , inageURL: imageURL , docID: docID, placeID: placeID )
                places.append(place)
                
            }
            completion(.success(places))
        }
        
    }
    
    // MARK: - Store userdata while register
    
     func storeFirstTimeUserIntoDatabase(email:String, uid:String, username:String, fullname:String, completion:@escaping(Result<Void,FirestoreError>) -> Void){
        
        let data = [
            "email": email,
            "username": username,
            "fullname": fullname,
            "uid": uid,
            
        ]
        
        database.collection("users").document(uid).setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
                completion(.failure(.errorInStoringUserData))
            }
            completion(.success(()))
        }
    }
    
    func fetchUserData(completion:@escaping(Result<User,FirestoreError>) -> Void){
        database.collection("users").document(user?.uid ?? "").getDocument { snapshot, error in
            guard let document = snapshot, error == nil else {
                print("Document does not exist")
                completion(.failure(.errorInFetchingUserData))
                return
            }
            guard let data = document.data() else {
                print("Document data is nil")
                completion(.failure(.errorInFetchingUserData))
                return
            }
        
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let decodedUser = try JSONDecoder().decode(User.self, from: jsonData)
                completion(.success(decodedUser))
            }catch{
                print("Failed to decode")
                completion(.failure(.errorInFetchingUserData))
                
            }
            
        }
    }
}
