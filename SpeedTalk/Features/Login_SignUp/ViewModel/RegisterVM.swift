//
//  RegisterVM.swift
//  SpeedTalk
//
//  Created by User on 03/05/25.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RegisterVM {
    
    static let shared = RegisterVM()
    var errorMessage: String?
    func registerUser(
        user: UserDataModel,
        password: String,
        completion: @escaping (Result<UserDataModel, Error>) -> Void
    ) {
        // Create Firebase user
        Auth.auth().createUser(withEmail: user.email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = authResult?.user else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User creation failed"])))
                return
            }
            
            // Update user with UID from Firebase
            var registeredUser = user
            registeredUser.uid = firebaseUser.uid
            // Prepare user data with createdAt
            var userData = registeredUser.toDictionary()
            userData["createdAt"] = ServerValue.timestamp()
            
            // Save to database
            self.saveUserData(user: registeredUser, data: userData) { result in
                switch result {
                case .success:
                    completion(.success(registeredUser))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
    }
    
    // MARK: - Helper Methods
    
//    private func updateUserProfile(user: FirebaseAuth.User, name: String, completion: @escaping (Error?) -> Void) {
//        let changeRequest = user.createProfileChangeRequest()
//        changeRequest.displayName = name
//        changeRequest.commitChanges(completion: completion)
//    }
//
    private func saveUserData(user: UserDataModel, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let databaseRef = Database.database().reference()
        let usersRef = databaseRef.child("EmailUsers").child(user.uid)
        
        usersRef.setValue(data) { error, _ in
            if let error = error {
                completion(.failure(error))
                return
            }
            // Store user ID in UserDefaults if needed
            UserDefaults.standard.set(user.uid, forKey: UserDefaultKeys.shared.uidKey)
            UserDefaults.standard.set(UserDefaultKeys.shared.EmailUsers, forKey: UserDefaultKeys.shared.loginType)
            completion(.success(()))
        }
    }
    
//    // Optional: Send email verification
//    func sendEmailVerification(completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let user = Auth.auth().currentUser else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No authenticated user"])))
//            return
//        }
//
//        user.sendEmailVerification { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    }
    
    // MARK: - Login
       func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
           Auth.auth().signIn(withEmail: email, password: password) { result, error in
               if let error = error {
                   self.errorMessage = error.localizedDescription
                   completion(false)
               } else {
                   // Set loginType and uid
                   UserDefaults.standard.set(UserDefaultKeys.shared.EmailUsers, forKey: UserDefaultKeys.shared.loginType)
                   UserDefaults.standard.set(result?.user.uid, forKey: UserDefaultKeys.shared.uidKey)

                   // Fetch user details from DB
                   UserManager.shared.fetchUserData { fetchResult in
                       switch fetchResult {
                       case .success:
                           completion(true)
                       case .failure(let fetchError):
                           self.errorMessage = fetchError.localizedDescription
                           completion(false)
                       }
                   }
               }
           }
       }
    
    // MARK: - Forgot Password
      func resetPassword(email: String, completion: @escaping (Bool) -> Void) {
          Auth.auth().sendPasswordReset(withEmail: email) { error in
              if let error = error {
                  self.errorMessage = error.localizedDescription
                  completion(false)
              } else {
                  completion(true)
              }
          }
      }
}
