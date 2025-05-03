//

//
//  UserManager.swift
//  SpeedTalk
//
//  Created by User on 03/05/25.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn
import AuthenticationServices

class UserManager {
    static let shared = UserManager()
    private init() {}

    var currentUserData: [String: Any]?

    private var loginType: String? {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.shared.loginType)
    }

    private var uid: String? {
        return Auth.auth().currentUser?.uid
    }

    // MARK: - Fetch User
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let uid = uid else {
            completion(.failure(NSError(domain: "No UID", code: -1)))
            return
        }

        guard let type = loginType else {
            completion(.failure(NSError(domain: "No login type", code: -1)))
            return
        }

        let ref = Database.database().reference().child(type).child(uid)
        ref.observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                self.currentUserData = data
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "User not found", code: 404)))
            }
        }
    }

    // MARK: - Update User
    func updateUserData(updatedData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uid = uid, let type = loginType else {
            completion(.failure(NSError(domain: "Missing user data", code: -1)))
            return
        }

        let ref = Database.database().reference().child(type).child(uid)
        ref.updateChildValues(updatedData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                self.currentUserData?.merge(updatedData) { (_, new) in new }
                completion(.success(()))
            }
        }
    }

    // MARK: - Delete User
    func deleteUser(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uid = uid, let type = loginType else {
            completion(.failure(NSError(domain: "Missing login type or UID", code: -1)))
            return
        }

        // Delete from Firebase Auth
        Auth.auth().currentUser?.delete { authError in
            if let authError = authError {
                completion(.failure(authError))
                return
            }

            // Delete from Database
            let ref = Database.database().reference().child(type).child(uid)
            ref.removeValue { dbError, _ in
                if let dbError = dbError {
                    completion(.failure(dbError))
                } else {
                    self.signOutUser() // Clean UserDefaults
                    completion(.success(()))
                }
            }
        }
    }

    // MARK: - Sign Out
    func signOutUser() {
        do {
            if loginType == UserDefaultKeys.shared.GoogleUsers {
                GIDSignIn.sharedInstance.signOut()
            }

            if loginType == UserDefaultKeys.shared.AppleUsers {
                // No explicit signOut for Apple, but you can clear credentials if needed
                // Optionally revoke credentials using ASAuthorizationAppleIDProvider
                if let appleUserID = UserDefaults.standard.string(forKey: UserDefaultKeys.shared.appleIDKey) {
                    ASAuthorizationAppleIDProvider().getCredentialState(forUserID: appleUserID) { state, _ in
                        switch state {
                        case .revoked, .notFound:
                            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.shared.appleIDKey)
                        default: break
                        }
                    }
                }
            }

            try Auth.auth().signOut()

            // Clear UserDefaults
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.shared.uidKey)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.shared.googleTokenKey)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.shared.appleIDKey)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.shared.loginType)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.shared.hasCompletedOnboarding)

            currentUserData = nil
        } catch {
            print("Sign out failed: \(error.localizedDescription)")
        }
    }
}

/*
 Usage Examples
 UserManager.shared.fetchUserData { result in
     switch result {
     case .success(let data):
         print("User Data: \(data)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }
 Update Userdetails
 UserManager.shared.updateUserData(updatedData: ["name": "Updated Name"]) { result in
     switch result {
     case .success:
         print("Updated successfully")
     case .failure(let error):
         print("Update failed: \(error)")
     }
 }
  Delete User.
 UserManager.shared.deleteUser { result in
     switch result {
     case .success:
         print("User deleted successfully")
     case .failure(let error):
         print("Delete failed: \(error)")
     }
 }

 */
