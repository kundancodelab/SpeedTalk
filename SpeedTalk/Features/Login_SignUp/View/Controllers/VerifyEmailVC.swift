//
//  VerifyEmailVC.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//

import UIKit

class VerifyEmailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func navigateToHome() {
        let vc = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func didTapVerifyEmailBtn(_ sender: UIButton)  {
        Task {
            await   AuthViewModel.shared.checkIfEmailVerified()
        }
       
    }
    @IBAction func didSendVerifyEmailBtn(_ sender: UIButton)  {
        Task {
            Utility.showAlert(title: "Sent Email", message: "verificatin email sent to your email", viewController: self)
            await   AuthViewModel.shared.sendEmailVerification()
        }
       
    }
    
    @IBAction func didTapBackBtn(_ sender: UIButton)  {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension VerifyEmailVC {
    func configure() {
        initViewModel()
        eventObserver()
    }
    
    func initViewModel() {
    }
    
    func eventObserver() {
        AuthViewModel.shared.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading:
                LoaderManager.showLoader(on: self.view, message: "Sending verification email...")
            case .stopLoading:
                LoaderManager.hideLoader(from: self.view)
            case .success:
                LoaderManager.showSuccess(on: self.view, message: "Veryfied successfully")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // Move to HomeVC after success
                    self.navigateToHome()
                }
            case .error(let errorMessage):
                LoaderManager.showError(on: self.view, message: errorMessage)
            }
        }
    }
}
