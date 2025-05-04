//
//  UiVC+Extension.swift
//  SpeedTalk
//
//  Created by User on 03/05/25.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    static func dashboard() -> Self {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    func showHUD(progressLabel:String) {
            DispatchQueue.main.async {
                let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                progressHUD.label.text = progressLabel
            }
        }
       func dismissHUD(isAnimated:Bool){
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: isAnimated)
            }
        }
    func showToast(message: String, duration: Double, color: UIColor, isTop: Bool) {
        let toastView = UIView()
        toastView.backgroundColor = color
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        toastView.addSubview(messageLabel)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(toastView)
        
        if isTop == true {
            // Constraints for toastView
            NSLayoutConstraint.activate([
                toastView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
                toastView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20),
                toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                messageLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 275),
                messageLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 10),
                messageLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -10),
                messageLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10),
                messageLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10)
            ])
        } else {
            // Constraints for toastView
            NSLayoutConstraint.activate([
                toastView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
                toastView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20),
                toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                toastView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                messageLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 10),
                messageLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -10),
                messageLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10),
                messageLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10)
            ])
        }
        
        // Initial state (hidden)
        toastView.alpha = 0
        
        // Animate to show
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1
        }) { _ in
            // Animate to hide after delay
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastView.alpha = 0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
    
}
