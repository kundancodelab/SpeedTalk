//
//  HomeCell.swift
//  SpeedTalk
//
//  Created by User on 17/05/25.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unSeenMessageZCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }

    func configure(with data: HomeDM) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        profileImageView.image = UIImage(named: data.profileImage)
    }
}
