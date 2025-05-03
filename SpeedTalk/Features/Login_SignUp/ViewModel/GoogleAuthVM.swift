//
//  GoogleAuthVM.swift
//  SpeedTalk
//
//  Created by User on 29/04/25.
//



import Foundation
import Firebase
import FirebaseDatabase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class GoogleAuthVM {
    
    static let share = GoogleAuthVM()
    
    // MARK: Sign with google account itself
    func signInWithGoogle(completion: @escaping (Bool, [String: Any]?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = scene.windows.first?.rootViewController else {
            print("Error accessing rootViewController")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                completion(false, nil)
                return
            }
            
            guard let authentication = signInResult?.user else {
                print("Error retrieving authentication tokens")
                completion(false, nil)
                return
            }
            
            let idToken = authentication.idToken?.tokenString ?? ""
            let accessToken = authentication.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Firebase Sign-In Error: \(error.localizedDescription)")
                    completion(false, nil)
                    return
                }
                
                guard let user = result?.user else {
                    completion(false, nil)
                    return
                }
                // storing user's data into "GoogleUsers" Collection Name in firebase project console .
                let databaseRef = Database.database().reference()
                let usersRef = databaseRef.child("GoogleUsers")
                
                //let language = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? ""
                
                // Query the database to check if a user with the same token exists
                usersRef.queryOrdered(byChild: "tokenid").queryEqual(toValue: idToken)
                .observeSingleEvent(of: .value) { snapshot in
                    if snapshot.exists(), let userData = snapshot.value as? [String: Any] {
                        print("User found existed : \(userData)")
                        completion(true, userData) // Return existing user data
                        UserDefaults.standard.set(idToken, forKey:UserDefaultKeys.shared.googleTokenKey)
                        
                    } else {
                        // User does not exist, create a new entry
                        let newUserData: [String: Any] = [
                            "tokenid": idToken,
                            "uid": user.uid,
                            "email": user.email ?? "",
                            "name": user.displayName ?? "",
                            "photoURL": user.photoURL?.absoluteString ?? "",
                           // "language": language
                        ]
                        
                        //  Save Google Token
                        UserDefaults.standard.set(idToken, forKey: UserDefaultKeys.shared.googleTokenKey)
                       
                        usersRef.child(user.uid).setValue(newUserData) { error, _ in
                            if let error = error {
                                print("Error saving user data: \(error.localizedDescription)")
                                completion(false, nil)
                            } else {
                                print("User data saved successfully")
                                completion(true, newUserData)
                            }
                        }
                    }
                }
            }
        }
    }
}
