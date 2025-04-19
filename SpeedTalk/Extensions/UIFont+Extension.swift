//
//  UIFont+Extension.swift
//  SpeedTalk
//
//  Created by User on 20/04/25.
//

import Foundation
import UIKit
extension UIFont {
    static  func poppinsLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    static  func poppinsSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    static  func poppinsBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? .systemFont(ofSize: size)
    }
}
