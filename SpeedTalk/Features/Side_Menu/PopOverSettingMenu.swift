//
//  PopOverSettingMenu.swift
//  SpeedTalk
//
//  Created by User on 04/05/25.


import UIKit
protocol SideMenuDelegate: AnyObject {
    func didSelectSettings()
}

class PopOverSettingMenu: UIViewController {
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var containerView: UIView!
    weak var delegate: SideMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        sideMenuView.addGestureRecognizer(tap)
        sideMenuView.isUserInteractionEnabled = true

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Yes we are  tapping.")
        dismiss(animated: true)
      }
    
    @IBAction func didTapSettingBtn(_ sender : UIButton) {
        self.dismiss(animated: true) {
              self.delegate?.didSelectSettings()
          }
    }
  
}
