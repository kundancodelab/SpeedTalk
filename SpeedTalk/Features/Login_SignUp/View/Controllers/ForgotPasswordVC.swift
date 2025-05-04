//
//  ForgotPasswordVC.swift
//  SpeedTalk
//
//  Created by User on 04/05/25.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapBackToLoginBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapforgotPasswordBtn(_ sender: UIButton) {
        guard let email = emailTF.text, !email.isEmpty else {
            Utility.alertDisplay(vc: self, titleMsg: "Invalid email ", displayMessage: "Invalid email or empty", buttonLabel: "ok")
            return
        }
        
        self.showHUD(progressLabel: "sending...")
        RegisterVM.shared.resetPassword(email: email) { success in
            self.dismissHUD(isAnimated: true)
            if success {
                self.showToast(message: "Sent successfully", duration: 0.5 , color: .systemGray5, isTop: true)
            }else {
                Utility.alertDisplay(vc: self, titleMsg: "Failed", displayMessage: "something went wrong, Please ensure you are entering the registered email", buttonLabel: "ok")
            }
        }
            
        
    }
}
