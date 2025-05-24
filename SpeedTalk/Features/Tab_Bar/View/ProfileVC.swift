//
//  ProfileVC.swift
//  SpeedTalk
//
//  Created by User on 25/05/25.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var logoutView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Actions
    
    @IBAction func didTapBackBtn(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 
}
