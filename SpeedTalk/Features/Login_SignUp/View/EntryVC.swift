//
//  ViewController.swift
//  SpeedTalk
//
//  Created by User on 20/04/25.
//

import UIKit

class EntryVC: UIViewController {
    
    @IBOutlet weak var buttonView: UIView!{
        didSet {
            buttonView.layer.cornerRadius = 8
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
//        lable.text = "Hello I am kundan using custom font."
//        view.addSubview(lable)
//        lable.center = view.center
//        lable.font = .poppinsBold(size: 30)
//        lable.numberOfLines = 0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    @IBAction func didTapGetStartedBtn(_ sender: UIButton) {
        let vc = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "LoginVC" ) as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

