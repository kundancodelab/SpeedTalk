//
//  LoginVC.swift
//  SpeedTalk
//
//  Created by User on 26/04/25.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase

class LoginVC: UIViewController {
    private let googleAuthVM = GoogleAuthVM()
    @IBOutlet weak var loginBtnView: UIView!{
        didSet {
            loginBtnView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
   
    
    @IBAction func didTapBackBtn(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapGoogleLoginBtn(_ sender: UIButton) {
        handleGoogleLogin()
    }
    
    @IBAction func didTapAppleLoginBtn(_ sender: UIButton) {
       
    }
    @IBAction func didTapLoginBtn(_ sender: UIButton ) {
        self.showHUD(progressLabel: "Logining...")
        print("userName:", emailTF.text! , "Password:", passwordTF.text!)
        RegisterVM.shared.loginUser(email: emailTF.text!, password: passwordTF.text!) { success in
            self.dismissHUD(isAnimated: true)
            if success {
                self.showToast(message: "Login successfully", duration: 1.0, color: .systemGreen.withAlphaComponent(0.4), isTop: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.navigateToHome()
                }
            }else {
             
                Utility.showAlert(title: "Login Failed", message: RegisterVM.shared.errorMessage ?? "Something went wrong ", viewController: self)
            }
        }
    }
    
    @IBAction func didTapForgotPassword(_ sender: UIButton) {
        let ForgotPasswordVC = ForgotPasswordVC.instantiate()
        self.navigationController?.pushViewController(ForgotPasswordVC, animated: true)
    }

}

extension LoginVC {
    private func setupTextField() {
        // Customize email text field
        emailTF.placeholder = "Enter your email address"
        emailTF.layer.cornerRadius = 8
        emailTF.layer.borderWidth = 1.0
        emailTF.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        emailTF.clipsToBounds = true
        emailTF.delegate = self
        // Customize password text field
        passwordTF.placeholder = "Enter Password"
        passwordTF.layer.cornerRadius = 8
        passwordTF.layer.borderWidth = 1.0
        passwordTF.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        passwordTF.clipsToBounds = true
        passwordTF.delegate = self
        passwordTF.isSecureTextEntry = true
        passwordTF.textContentType = .newPassword
        }
  private  func handleGoogleLogin() {
      
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            print(" Missing Firebase Client ID")
//            return
//        }
//
//        let config = GIDConfiguration(clientID: clientID)
//
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [weak self] user, error in
//            if let error = error {
//                print(" Google Sign-In Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let idToken = user?.authentication.idToken,
//                  let accessToken = user?.authentication.accessToken else {
//                print(" Google Sign-In Failed: Missing tokens")
//                return
//            }
      self.showHUD(progressLabel: "Loading...")
      GoogleAuthVM.share.signInWithGoogle{ success, userData in
          //Hide loder
          self.dismissHUD(isAnimated: true)
          if success {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                  let userID = userData?["uid"] as? String
                  print(userID)
                  //  Save Login Type
                  UserDefaults.standard.set(UserDefaultKeys.shared.GoogleUsers, forKey:UserDefaultKeys.shared.loginType)
                  //  Save UID
                  UserDefaults.standard.set(userID, forKey: UserDefaultKeys.shared.uidKey)
                  UserDefaults.standard.set(true, forKey: UserDefaultKeys.shared.hasCompletedOnboarding)
                  self.navigateToHome()
              }
          } else {
              print("error")
              Utility.alertDisplay(vc: self, titleMsg: "Failed", displayMessage: "Something went wrong!", buttonLabel: "dismiss")
          }
      }
        }
    }

//MARK: Helper Method
extension LoginVC{
    private func navigateToHome(){
        let homeVC = HomeVC.instantiate()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
// MARK: UITextfieldDelegate Methods
extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
