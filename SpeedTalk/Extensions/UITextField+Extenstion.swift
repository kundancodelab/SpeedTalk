//
//  UITextField+Extenstion.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//



import Foundation
import UIKit
extension UITextField {
    
    // MARK: - Placeholder Customization
    func setPlaceholder(_ text: String, color: UIColor = .lightGray) {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color]
        )
    }
   
    func setPlaceholder(_ text: String, attributes: [NSAttributedString.Key: Any]) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    // MARK: - Appearance
    func setCornerRadius(_ radius: CGFloat, roundedCorners: CACornerMask? = nil) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        if let corners = roundedCorners {
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = corners
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    // MARK: - Padding
    /// Sets left padding
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    /// Sets right padding
    func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    /// Sets both left and right padding
    func setHorizontalPadding(_ amount: CGFloat) {
        setLeftPadding(amount)
        setRightPadding(amount)
    }
    // MARK: - Combined Setup
    /// Quick setup with common parameters
    func setup(placeholder: String? = nil,
               placeholderColor: UIColor = .lightGray,
               backgroundColor: UIColor? = nil,
               cornerRadius: CGFloat = 0,
               borderColor: UIColor? = nil,
               borderWidth: CGFloat = 0,
               leftPadding: CGFloat = 0,
               rightPadding: CGFloat = 0) {
        
        if let placeholder = placeholder {
            setPlaceholder(placeholder, color: placeholderColor)
        }
        
        if let backgroundColor = backgroundColor {
            setBackgroundColor(backgroundColor)
        }
        
        if cornerRadius > 0 {
            setCornerRadius(cornerRadius)
        }
        
        if let borderColor = borderColor {
            setBorder(color: borderColor, width: borderWidth)
        }
        
        if leftPadding > 0 {
            setLeftPadding(leftPadding)
        }
        
        if rightPadding > 0 {
            setRightPadding(rightPadding)
        }
    }
}
