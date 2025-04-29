//
//  GoogleAuthVM.swift
//  SpeedTalk
//
//  Created by User on 29/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

final class GoogleAuthViewModel {
    
    // Reference to the shared AuthViewModel to use existing session management
    private let authViewModel = AuthViewModel.shared
    
    var eventHandler: ((AuthState) -> Void)?
    
    init() {}
    
    // Google SignIn Login
    func loginWithGoogle(idToken: String, accessToken: String) async {
        eventHandler?(.loading)
        do {
            // Create a Firebase credential with Google ID token and access token
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // Sign in with Firebase using Google credentials
            let authResult = try await authViewModel.auth.signIn(with: credential)
            let uid = authResult.user.uid
            
            // Store the Google user in Firestore under GoogleUser collection
            await storeGoogleUserInFirebase(uid: uid, email: authResult.user.email ?? "No Email")
            
            // Fetch user data after successful login
            await authViewModel.fetchUser(by: uid)
            
            eventHandler?(.success)
        } catch {
            eventHandler?(.error(error.localizedDescription))
        }
        eventHandler?(.stopLoading)
    }
    
    // Store Google User in Firebase under GoogleUser collection
    private func storeGoogleUserInFirebase(uid: String, email: String) async {
        // Here you can create a UserDM or any custom model for Google users
        let googleUser = UserDM(fullName: "", email: email, uid: uid, name: "Google User")
        
        do {
            // Save the user data in Firestore under GoogleUser collection
            try await authViewModel.firestore.collection("GoogleUser").document(uid).setData(from: googleUser)
            
            // Optionally, save user data to UserDefaults
            UserDefaults.standard.set(email, forKey: "googleUserEmail")
        } catch {
            eventHandler?(.error("Failed to save Google user"))
        }
    }
}
