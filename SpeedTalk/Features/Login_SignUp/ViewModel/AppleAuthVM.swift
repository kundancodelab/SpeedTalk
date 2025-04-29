//
//  AppleAuthVM.swift
//  SpeedTalk
//
//  Created by User on 29/04/25.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices

final class AppleAuthViewModel {
    
    // Reference to the shared AuthViewModel to use existing session management
    private let authViewModel = AuthViewModel.shared
    
    var eventHandler: ((AuthState) -> Void)?
    
    init() {}
    
    // Apple SignIn Login
    func loginWithApple(authorizationCode: String, idToken: String) async {
        eventHandler?(.loading)
        do {
            // Create a Firebase credential with Apple ID token
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: authorizationCode)
            
            // Sign in with Firebase using Apple credentials
            let authResult = try await authViewModel.auth.signIn(with: credential)
            let uid = authResult.user.uid
            
            // Store the Apple user in Firestore under AppleUser collection
            await storeAppleUserInFirebase(uid: uid)
            
            // Fetch user data after successful login
            await authViewModel.fetchUser(by: uid)
            
            eventHandler?(.success)
        } catch {
            eventHandler?(.error(error.localizedDescription))
        }
        eventHandler?(.stopLoading)
    }
    
    // Store Apple User in Firebase under AppleUser collection
    private func storeAppleUserInFirebase(uid: String) async {
        // Here you can create a UserDM or any custom model for Apple users
        let appleUser = UserDM(fullName: "", email: "apple@example.com", uid: uid, name: "Apple User")
        
        do {
            // Save the user data in Firestore under AppleUser collection
            try await authViewModel.firestore.collection("AppleUser").document(uid).setData(from: appleUser)
            
            // Optionally, save user data to UserDefaults
            UserDefaults.standard.set(uid, forKey: "appleUserUID")
        } catch {
            eventHandler?(.error("Failed to save Apple user"))
        }
    }
}
