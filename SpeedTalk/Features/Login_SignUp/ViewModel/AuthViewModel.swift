//
//  AuthViewModel.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthState {
    case loading
    case stopLoading
    case success
    case error(String)
}

final class AuthViewModel {
    
    static let shared = AuthViewModel()
    
     let auth = Auth.auth()
     let firestore = Firestore.firestore()
    
    var userSession: FirebaseAuth.User?
    var currentUser: UserDM?
    var isError: Bool = false
    var eventHandler: ((AuthState) -> Void)?
    
    init() {}
    
    // MARK: - Create User
    func createUser(user: UserDM, email: String, password: String) async {
        eventHandler?(.loading)
        do {
            let authResult = try await auth.createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            userSession = authResult.user
            await storeUserInFirebase(uid: uid, user: user)
            await fetchUser(by: uid)
            eventHandler?(.success)
            // After user created, send verification email
           // await sendEmailVerification()
            
        } catch {
            isError = true
            eventHandler?(.error(error.localizedDescription))
        }
        eventHandler?(.stopLoading)
    }
    
    // MARK: - Login User
    func login(email: String, password: String) async {
        eventHandler?(.loading)
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUser(by: authResult.user.uid)
            eventHandler?(.success)
        } catch {
            isError = true
            eventHandler?(.error(error.localizedDescription))
        }
        eventHandler?(.stopLoading)
    }
    
    // MARK: - Store User in Firestore
    func storeUserInFirebase(uid: String, user: UserDM) async {
        do {
            try firestore.collection("Emailusers").document(uid).setData(from: user)
        } catch {
            isError = true
            eventHandler?(.error(error.localizedDescription))
        }
    }
    
    // MARK: - Fetch User
    func fetchUser(by uid: String) async {
        do {
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: UserDM.self)
        } catch {
            isError = true
            eventHandler?(.error(error.localizedDescription))
        }
    }
    
    // MARK: - Send Email Verification
    func sendEmailVerification() async {
        eventHandler?(.loading)
        do {
            guard let user = auth.currentUser else {
                eventHandler?(.error("No current user available."))
                eventHandler?(.stopLoading)
                return
            }
            try await user.sendEmailVerification()
            print("Verification Email Sent.")
            eventHandler?(.success)
        } catch {
            isError = true
            eventHandler?(.error(error.localizedDescription))
        }
        eventHandler?(.stopLoading)
    }
    
    // MARK: - Check If Email Verified
    func checkIfEmailVerified() async {
        eventHandler?(.loading)
        do {
            guard let user = auth.currentUser else {
                eventHandler?(.error("No current user available."))
                eventHandler?(.stopLoading)
                return
            }
            try await user.reload()
            
            if user.isEmailVerified {
                eventHandler?(.success)
            } else {
                eventHandler?(.error("Email not verified yet."))
            }
            
        } catch {
            isError = true
            eventHandler?(.error(error.localizedDescription))
        }
        eventHandler?(.stopLoading)
    }
    
    // MARK: - Logout
    func logout() {
        do {
            try auth.signOut()
            userSession = nil
            currentUser = nil
            eventHandler?(.success)
        } catch {
            eventHandler?(.error(error.localizedDescription))
        }
    }
}
