//
//  LoginVC.swift
//  SpeedTalk
//
//  Created by User on 26/04/25.
//

import UIKit

class LoginVC: UIViewController {
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
}
// MARK: UITextfieldDelegate Methods
extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
