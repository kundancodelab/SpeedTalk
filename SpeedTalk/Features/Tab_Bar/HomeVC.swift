//
//  HomeVC.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//

import UIKit
@MainActor
class HomeVC: UIViewController {
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!
    @IBOutlet weak var ageLbl:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    private func setupUI(){
        if let user = AuthViewModel.shared.currentUser {
            nameLbl.text = "Full Name: \(user.fullName)"
            emailLbl.text = "Email: \(user.email)"
            ageLbl.text = "Age: \(user.age ?? 18)"
        }else {
            print("Not accessing the current user data ")
        }
    }

   

}
