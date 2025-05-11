//
//  AuthService.swift
//  Xplore
//
//  Created by Dilshad P on 10/05/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthError: Error {
    case errorInRegisteringUser
    case invalidResultFromRegisteringUser
    case errorInLoginUser
}

enum FirestoreError: Error {
    case errorInStoringUserData
    case errorInFetchingUserData
}

class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    let databaseService = DatabaseServices()
    
    func registerUser(email:String, password:String, username:String, fullname:String, completion:@escaping(Result<Bool,AuthError>) -> Void){
        
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let strongSelf = self, error == nil else {
                completion(.failure(.errorInRegisteringUser))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(.invalidResultFromRegisteringUser))
                return
            }
            
            strongSelf.databaseService.storeFirstTimeUserIntoDatabase(email: email, uid: user.uid, username: username, fullname: fullname) { result in
                switch result {
                case .success(let success):
                    completion(.success(true))
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
            
        }
        
    }
    

    
    func loginUser(email: String, password:String,completion:@escaping(Result<Bool,AuthError>) -> Void){
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                completion(.failure(.errorInLoginUser))
                return
            }
            
            print(user.email ?? "no name")
            completion(.success(true))
        }
    }
    
    func signOut() throws{
        do {
           try auth.signOut()
        }catch{
            print("unable to signout")
        }
    }
}
