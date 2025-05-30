//
//  UIView+Extension.swift
//  SpeedTalk
//
//  Created by User on 30/05/25.
//

import Foundation
import UIKit
extension UIView {
    
    // MARK: - Basic Fade with Action
    func animateWithFadeAndAction(duration: TimeInterval = 0.1,
                                  fadeAlpha: CGFloat = 0.5,
                                  action: @escaping () -> Void) {
        let originalAlpha = self.alpha
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = fadeAlpha
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.alpha = originalAlpha
            }) { _ in
                action()
            }
        }
    }
    // MARK: - Bounce & Fade Tap
      
    func bounceFadeTap(action: @escaping () -> Void) {
           UIView.animate(withDuration: 0.1,
                          animations: {
                              self.alpha = 0.5
                              self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                          }) { _ in
               UIView.animate(withDuration: 0.1,
                              animations: {
                                  self.alpha = 1.0
                                  self.transform = .identity
                              }) { _ in
                   action()
               }
           }
       }
    
    // MARK: - Bounce, Fade & Temporary Background Highlight
    func animateWithBounceFadeAndBackground(duration: TimeInterval = 0.1,
                                            fadeAlpha: CGFloat = 0.5,
                                            backgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3),
                                            action: @escaping () -> Void) {
        
        let originalAlpha = self.alpha
        let originalColor = self.backgroundColor
        let originalTransform = self.transform
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = fadeAlpha
            self.backgroundColor = backgroundColor
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.alpha = originalAlpha
                self.backgroundColor = originalColor
                self.transform = originalTransform
            }) { _ in
                action()
            }
        }
    }
}


   

