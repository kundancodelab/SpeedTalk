import UIKit
import SystemConfiguration
import Foundation


class Utility {
   
    // MARK: - Email Validation
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static  func addEyeIcon(_ textfield: UITextField){
        let rightImage  = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightImage.image = UIImage(named: "hiddeneye")
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        rightView.addSubview(rightImage)
        textfield.rightViewMode = .always
        textfield.rightView = rightView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility(_:)))
              rightImage.isUserInteractionEnabled = true  // Make the image tappable
              rightImage.addGestureRecognizer(tapGesture)
    }
    @objc static func togglePasswordVisibility(_ sender: UITapGestureRecognizer) {
            // Find the text field that is associated with the eye button
            guard let textfield = sender.view?.superview?.superview as? UITextField else { return }
            textfield.isSecureTextEntry.toggle()
            if textfield.isSecureTextEntry {
                if let rightImage = textfield.rightView?.subviews.first as? UIImageView {
                    rightImage.image = UIImage(named: "hiddeneye")
                }
            } else {
                if let rightImage = textfield.rightView?.subviews.first as? UIImageView {
                    rightImage.image = UIImage(named: "openeye")
                }
            }
        }
    // MARK: - Phone Number Validation
    static func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    // MARK: - Password Validation
    static func isPasswordValid(password: String) -> Bool {
        return isAtLeastEightCharacters(password: password) &&
               containsUppercaseAndLowercase(password: password) &&
               containsNumberAndSpecialCharacter(password: password)
    }
    
    static func isAtLeastEightCharacters(password: String) -> Bool {
        return password.count >= 8
    }
    
    static func containsUppercaseAndLowercase(password: String) -> Bool {
        let hasUppercase = password.contains { $0.isUppercase }
        let hasLowercase = password.contains { $0.isLowercase }
        return hasUppercase && hasLowercase
    }
    
    static func containsNumberAndSpecialCharacter(password: String) -> Bool {
        return containsNumber(password: password) && containsSpecialCharacter(password: password)
    }
    
    static func containsNumber(password: String) -> Bool {
        let numberPattern = ".*[0-9]+.*"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberPattern)
        return numberPredicate.evaluate(with: password)
    }
    
    static func containsSpecialCharacter(password: String) -> Bool {
        let specialCharacterPattern = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterPattern)
        return specialCharacterPredicate.evaluate(with: password)
    }
    
    static func validatePassword(password: String) -> String? {
        if !isAtLeastEightCharacters(password: password) {
            return "Password must be at least 8 characters long."
        }
        if !containsUppercaseAndLowercase(password: password) {
            return "Password must include a mix of uppercase and lowercase letters."
        }
        if !containsNumberAndSpecialCharacter(password: password) {
            if !containsNumber(password: password) {
                return "Password must include at least one number."
            }
            if !containsSpecialCharacter(password: password) {
                return "Password must include at least one special character."
            }
        }
        return nil
    }
    
    // MARK: - Pincode Validation
    static func isValidPincode(value: String) -> Bool {
        return value.count == 6
    }
    
    // MARK: - Password Match Validation
    static func isPasswordSame(password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
    // MARK: - Password Length Validation
    static func isPwdLength(password: String, confirmPassword: String) -> Bool {
        return password.count >= 8 && confirmPassword.count >= 8
    }
    
    // MARK: - Name Validation
    static func isValidName(_ name: String?, minLength: Int = 2) -> Bool {
        guard let name = name, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        if name.trimmingCharacters(in: .whitespaces).count < minLength {
            return false
        }
        
        let nameRegex = "^[A-Za-z]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    
    // MARK: - Address Validation
    static func isValidAddress(_ address: String?, minLength: Int = 5) -> Bool {
        guard let address = address, !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        if address.trimmingCharacters(in: .whitespaces).count < minLength {
            return false
        }
        
        let addressRegex = "^[A-Za-z0-9.,'\\-\\s]+$"
        let addressPredicate = NSPredicate(format: "SELF MATCHES %@", addressRegex)
        return addressPredicate.evaluate(with: address)
    }
    
    // MARK: - Mobile Number Validation
    static func isValidMobileNumber(_ mobileNumber: String?) -> Bool {
        guard let mobileNumber = mobileNumber, !mobileNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        let mobileNumberRegex = "^[0-9]{10}$"
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberPredicate.evaluate(with: mobileNumber)
    }
    
    // MARK: - Zip Code Validation (Indian Zip Code)
    static func isValidIndianZipCode(_ zipCode: String?) -> Bool {
        guard let zipCode = zipCode, !zipCode.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        let zipCodeRegex = "^[1-9][0-9]{5}$"
        let zipCodePredicate = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        return zipCodePredicate.evaluate(with: zipCode)
    }
    
    // MARK: - Display Alert
    static func alertDisplay(vc: UIViewController, titleMsg: String, displayMessage: String, buttonLabel: String) {
        let alert = UIAlertController(title: titleMsg, message: displayMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }

    
//    // MARK: - Hide Keyboard When Tapped
//    static func hideKeyboardWhenTappedAround(vc: UIViewController) {
//        let tap = UITapGestureRecognizer(target: vc, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        vc.view.addGestureRecognizer(tap)
//    }
//
//    @objc static func dismissKeyboard() {
//        UIApplication.shared.keyWindow?.endEditing(true)
//    }
    
    // MARK: - Show Toast Message
    static func showToast(vc: UIViewController, message: String, font: UIFont) {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: vc.view.frame.size.width / 2 - 130, y: vc.view.frame.size.height - 170, width: 250, height: 35))
            toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.75)
            toastLabel.textColor = UIColor.black
            toastLabel.font = font
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            vc.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }
    
    // MARK: - Network Connectivity
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return isReachable && !needsConnection
    }
}
