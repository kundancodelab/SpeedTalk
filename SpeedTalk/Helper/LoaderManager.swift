//
//  LoaderManager.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//

import Foundation
import UIKit
import MBProgressHUD

final class LoaderManager {

    private init() {}

    // MARK: - Show Loader
    static func showLoader(on view: UIView, message: String = "Loading...") {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.label.text = message
        }
    }
    
    // MARK: - Hide Loader
    static func hideLoader(from view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    // MARK: - Show Success Message
    static func showSuccess(on view: UIView, message: String = "Success") {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .customView
            hud.customView = UIImageView(image: UIImage(systemName: "checkmark.circle"))
            hud.label.text = message
            hud.hide(animated: true, afterDelay: 2)
        }
    }
    
    // MARK: - Show Error Message
    static func showError(on view: UIView, message: String = "Error") {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .customView
            hud.customView = UIImageView(image: UIImage(systemName: "xmark.octagon"))
            hud.label.text = message
            hud.hide(animated: true, afterDelay: 2)
        }
    }
}
