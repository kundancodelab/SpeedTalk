//
//  ProfileVC.swift
//  SpeedTalk
//
//  Created by User on 25/05/25.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cameraImageBtn: UIButton!
    // UILables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
  
    // UIView
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var logoutView:UIView!
    //  Properties
    var userData:[String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGestureTo(view: nameView, action: #selector(didTapNameView))
        addTapGestureTo(view: aboutView, action: #selector(didTapAboutView))
        addTapGestureTo(view: phoneView, action: #selector(didTapPhoneView))
        addTapGestureTo(view: emailView, action: #selector(didTapEmailView))
        addTapGestureTo(view: logoutView, action: #selector(didTapLogoutView))
        loadCurrentUserData()
        loadUserData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Actions
    @IBAction func didTapBackBtn(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: Helper Methods .
    private func loadCurrentUserData() {
        if let loginType = UserDefaults.standard.string(forKey: UserDefaultKeys.shared.loginType) {
            if loginType == UserDefaultKeys.shared.EmailUsers {
                 let  uid = UserDefaultKeys.shared.uidKey
                print("Email User")
            }else if loginType == UserDefaultKeys.shared.GoogleUsers {
                let googleToken = UserDefaultKeys.shared.googleTokenKey
                print("Google user ")
            }else {
                let appleToken = UserDefaultKeys.shared.appleIDKey
                print("Apple  User")
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
    
    // MARK: Method  SetupUI
    private func setupUI() {
        if let name = userData?["name"] as? String {
            nameLabel.text = name
        }
        if let email = userData?["email"] as? String {
            emailLabel.text = email
        }
        if let about = userData?["about"] as? String {
            aboutLabel.text = about
        }
        if let phone = userData?["phone"] as? String {
            phoneLabel.text = phone
        }
    }

    
    // MARK: Tap gestures
    private func addTapGestureTo(view: UIView, action: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    @objc private func didTapNameView() {
        // Navigate to update name screen
        nameView.animateWithBounceFadeAndBackground {
            print("name View Tapped")
        }
    }

    @objc private func didTapAboutView() {
        // Navigate to update about screen
        aboutView.animateWithBounceFadeAndBackground {
            print("About View Tapped")
        }
       
    }

    @objc private func didTapPhoneView() {
        // Navigate to update phone screen
        phoneView.animateWithBounceFadeAndBackground {
            print("Phone View Tapped")
        }
    }

    @objc private func didTapEmailView() {
        // Navigate to update email screen
        emailView.animateWithBounceFadeAndBackground {
            print("email View Tapped")
        }
    }

    @objc private func didTapLogoutView() {
        logoutView.animateWithBounceFadeAndBackground {
            self.showHUD(progressLabel: "Logging out...")

            // Call sign out first
            UserManager.shared.signOutUser()

            // Delay to simulate logout process
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismissHUD(isAnimated: true)

                // Navigate to login or welcome screen
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {

                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let logicVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                    let navVC = UINavigationController(rootViewController: logicVC)

                    sceneDelegate.window?.rootViewController = navVC
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }
        }
    }



 
}
