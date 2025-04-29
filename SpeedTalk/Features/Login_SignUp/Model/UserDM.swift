//
//  User.swift
//  SpeedTalk
//
//  Created by User on 27/04/25.
//

import Foundation
//struct UserDM : Codable {
//    var uid: String
//    let userName: String
//    let email: String
//    var age: Int?
//    var weight: Double?
//    var gender: String?
//    var lifeStage: String?
//    var profilePicURL: String?
//    var isEmailVerified: Bool
//    
//    init(uid: String, userName: String, email: String, age: Int? = nil, weight: Double? = nil,
//         gender: String? = nil, lifeStage: String? = nil, profilePicURL: String? = nil,
//         isEmailVerified: Bool = false) {
//        self.uid = uid
//        self.userName = userName
//        self.email = email
//        self.age = age
//        self.weight = weight
//        self.gender = gender
//        self.lifeStage = lifeStage
//        self.profilePicURL = profilePicURL
//        self.isEmailVerified = isEmailVerified
//    }
//    
//    init?(dictionary: [String: Any]) {
//        guard let uid = dictionary["uid"] as? String,
//              let userName = dictionary["userName"] as? String,
//              let email = dictionary["email"] as? String else {
//            return nil
//        }
//        
//        self.uid = uid
//        self.userName = userName
//        self.email = email
//        self.age = dictionary["age"] as? Int
//        self.weight = dictionary["weight"] as? Double
//        self.gender = dictionary["gender"] as? String
//        self.lifeStage = dictionary["lifeStage"] as? String
//        self.profilePicURL = dictionary["profilePicURL"] as? String
//        self.isEmailVerified = dictionary["isEmailVerified"] as? Bool ?? false
//    }
//    
//    func toDictionary() -> [String: Any] {
//        var dict: [String: Any] = [
//            "uid": uid,
//            "userName": userName,
//            "email": email,
//            "isEmailVerified": isEmailVerified
//        ]
//        
//        if let age = age { dict["age"] = age }
//        if let weight = weight { dict["weight"] = weight }
//        if let gender = gender { dict["gender"] = gender }
//        if let lifeStage = lifeStage { dict["lifeStage"] = lifeStage }
//        if let profilePicURL = profilePicURL { dict["profilePicURL"] = profilePicURL }
//        
//        return dict
//    }
//}

struct UserDM: Codable {
    let fullName: String
    let email: String
    var isEmailVerified: Bool
    var profilePicURL: String?
    var age:Int?
    
    // 👉 This normal initializer
    init(fullName: String, email: String, isEmailVerified: Bool = false,age:Int? = nil , profilePicURL: String? = nil) {
        self.fullName = fullName
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.age = age
        self.profilePicURL = profilePicURL
    }
    
    init?(dictionary: [String: Any]) {
        guard let fullName = dictionary["fullName"] as? String,
              let email = dictionary["email"] as? String else {
            return nil
        }
        self.fullName = fullName
        self.email = email
        self.isEmailVerified = dictionary["isEmailVerified"] as? Bool ?? false
        self.profilePicURL = dictionary["profilePicURL"] as? String
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "fullName": fullName,
            "email": email,
            "isEmailVerified": isEmailVerified
        ]
        if let age = age { dict["age"] = age }
        if let profilePicURL = profilePicURL {
            dict["profilePicURL"] = profilePicURL
        }
        return dict
    }
}
