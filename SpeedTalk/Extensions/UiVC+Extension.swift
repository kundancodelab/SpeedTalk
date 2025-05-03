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
}
