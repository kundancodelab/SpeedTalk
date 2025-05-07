//
//  footerCellTableViewCell.swift
//  SpeedTalk
//
//  Created by User on 08/05/25.
//

import UIKit

class footerCellTableViewCell: UITableViewCell {
    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    
    // callback clouser
    var onOpenInstagramTapped: (() -> Void)?
    var onOpenFacebookTapped: (() -> Void)?
    var onOpenThreadsTapped: (() -> Void)?
    var onOpenMetaAIAppTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with data: (String, String)) {
        img.image = UIImage(named: data.0)
        lblTitle.text =  data.1
    }
    
}
