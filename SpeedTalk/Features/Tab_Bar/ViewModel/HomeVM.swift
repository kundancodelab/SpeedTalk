//
//  HomeVM.swift
//  SpeedTalk
//
//  Created by User on 17/05/25.
//

import Foundation
class HomeVM {
    static let shared = HomeVM()
    
    private init() { } // Prevent external instantiation

    var homeData: [HomeDM] = [
        HomeDM(title: "Raju", subtitle: "Hey there! I’m using WhatsApp", profileImage: "profile1"),
        HomeDM(title: "Priya", subtitle: "Let’s catch up soon", profileImage: "profile2"),
        HomeDM(title: "Amit", subtitle: "At work 💼", profileImage: "profile3"),
        HomeDM(title: "Neha", subtitle: "Vacation mode on ✈️", profileImage: "profile4"),
        HomeDM(title: "Rahul", subtitle: "Available", profileImage: "profile5")
    ]
}
