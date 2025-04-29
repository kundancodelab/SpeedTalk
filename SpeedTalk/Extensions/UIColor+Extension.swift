//
//  UIColor+Extension.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//

import Foundation
import UIKit
extension UIColor {
    // Method to create UIColor from a hex code string
    static func colorFromHex(_ hex: String) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // Define some common colors as static variables
    static let primaryColor = colorFromHex("#3498db") ?? UIColor.blue
    static let secondaryColor = colorFromHex("#2ecc71") ?? UIColor.green
    static let accentColor = colorFromHex("#e74c3c") ?? UIColor.red
    static let backgroundColor = colorFromHex("#f5f5f5") ?? UIColor.lightGray
}
