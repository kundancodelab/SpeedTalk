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
    var userData:[String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // loadCurrentUserData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func didTapSideMenuBtn(_ sender: UIButton) {
        let sideMenuVC = PopOverSettingMenu.instantiate()
        sideMenuVC.modalTransitionStyle = .crossDissolve
        sideMenuVC.modalPresentationStyle = .overCurrentContext
        present(sideMenuVC, animated: true)
    }
   
}
// MARK: Helper methods
extension HomeVC {
    private func loadCurrentUserData() {
        if let loginType = UserDefaults.standard.string(forKey: UserDefaultKeys.shared.loginType) {
            if loginType == UserDefaultKeys.shared.EmailUsers {
                 let  uid = UserDefaultKeys.shared.uidKey
            }else if loginType == UserDefaultKeys.shared.GoogleUsers {
                let googleToken = UserDefaultKeys.shared.googleTokenKey
            }else {
                let appleToken = UserDefaultKeys.shared.appleIDKey
            }
        }
    }
    private func loadUserData() {
        UserManager.shared.fetchUserData { [self] result in
            switch result {
            case .success(let data):
                print("User Data: \(data)")
                userData = data
                self.setupUI()
            case .failure(let error):
                print("Did not get user data. Error: \(error)")
            }
        }
    }
    private func setupUI(){
       
//            nameLbl.text = "Full Name: \(userData.fullName)"
//            emailLbl.text = "Email: \(user.email)"
//            ageLbl.text = "Age: \(user.age ?? 18)"
    
    }
}
