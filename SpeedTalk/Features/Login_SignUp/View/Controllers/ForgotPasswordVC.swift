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
    
    @IBAction func didTapforgotPasswordBtn(_ sender: UIButton) {
        guard let email = emailTF.text, !email.isEmpty else {
            Utility.alertDisplay(vc: self, titleMsg: "Invalid email ", displayMessage: "Invalid email or empty", buttonLabel: "ok")
            return
        }
        
        self.showHUD(progressLabel: "sending...")
        RegisterVM.shared.resetPassword(email: email) { success in
            if success {
                Utility.showToast(vc: self, message: "Successfully sent password resent link", font: .systemFont(ofSize: 12))
            }else {
                Utility.alertDisplay(vc: self, titleMsg: "Failed", displayMessage: "something went wrong, Please ensure you are entering the registered email", buttonLabel: "ok")
            }
        }
            
        
    }
}
