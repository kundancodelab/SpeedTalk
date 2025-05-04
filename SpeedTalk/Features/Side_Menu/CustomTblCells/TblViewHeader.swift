//
//  TblViewHeader.swift
//  SpeedTalk
//
//  Created by User on 04/05/25.
//

import UIKit

class TblViewHeader: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var qrcodeImg: UIImageView!
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var addAccountImg: UIImageView!

    // MARK: - Callback Closures
    var onQRCodeTapped: (() -> Void)?
    var onAddAccountTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        // Corner Radius
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true

        // Optional Shadow
//        containerView.layer.shadowColor = UIColor.black.cgColor
//        containerView.layer.shadowOpacity = 0.1
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        containerView.layer.shadowRadius = 4

        // Profile image setup
        profileImg.image = UIImage(named: "apple")
        profileImg.contentMode = .scaleAspectFill
        profileImg.clipsToBounds = true

        // Add tap gestures
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(qrcodeImgTapped))
        qrcodeImg.isUserInteractionEnabled = true
        qrcodeImg.addGestureRecognizer(tapGesture1)

        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(addAccountImgTapped))
        addAccountImg.isUserInteractionEnabled = true
        addAccountImg.addGestureRecognizer(tapGesture2)
    }

    // MARK: - Actions
    @objc private func qrcodeImgTapped() {
        print("QR Code image tapped.")
        onQRCodeTapped?()
    }

    @objc private func addAccountImgTapped() {
        print("Add Account image tapped.")
        onAddAccountTapped?()
    }
}
