//
//  HomeVC.swift
//  SpeedTalk
//
//  Created by User on 28/04/25.
//

import UIKit
@MainActor
class HomeVC: UIViewController {
    // lables
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!
    @IBOutlet weak var ageLbl:UILabel!
    // TableView
    @IBOutlet weak var tblView:UITableView!
    // Button
    @IBOutlet weak var sideMenuBtn:UIButton!
    
    @IBOutlet weak var metaAiOverlayView: UIView!{
        didSet{
            metaAiOverlayView.layer.cornerRadius = 10
            metaAiOverlayView.layer.masksToBounds = true
            metaAiOverlayView.layer.shadowColor = UIColor.black.cgColor
            metaAiOverlayView.layer.shadowOpacity = 0.5
            metaAiOverlayView.layer.shadowRadius = 5
        }
    }
    @IBOutlet weak var addMemberOverlayView: UIView!{
        didSet{
            addMemberOverlayView.layer.cornerRadius = 10
            addMemberOverlayView.layer.masksToBounds = true
            addMemberOverlayView.layer.shadowColor = UIColor.black.cgColor
            addMemberOverlayView.layer.shadowOpacity = 0.5
            addMemberOverlayView.layer.shadowRadius = 5
        }
    }
    
    var userData:[String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadUserData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // loadCurrentUserData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func didTapSideMenuBtn(_ sender: UIButton) {
        let sideMenuVC = PopOverSettingMenu.instantiate()
        sideMenuVC.delegate = self
        sideMenuVC.modalTransitionStyle = .crossDissolve
        sideMenuVC.modalPresentationStyle = .overCurrentContext
        present(sideMenuVC, animated: true)
    }
    //MARK--> SetupTableView
    private func setupTableView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.showsVerticalScrollIndicator = false
        tblView.showsVerticalScrollIndicator = false
        tblView.separatorStyle = .none
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        tblView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    }
    
   
}

// MARK: Helper methods
extension HomeVC {
    private func loadCurrentUserData() {
        if let loginType = UserDefaults.standard.string(forKey: UserDefaultKeys.shared.loginType) {
            if loginType == UserDefaultKeys.shared.EmailUsers {
                 let  uid = UserDefaultKeys.shared.uidKey
            }else if loginType == UserDefaultKeys.shared.GoogleUsers {
                let googleToken = UserDefaultKeys.shared.googleTokenKey
            }else {
                let appleToken = UserDefaultKeys.shared.appleIDKey
            }
        }
    }
    private func loadUserData() {
        UserManager.shared.fetchUserData { [self] result in
            switch result {
            case .success(let data):
                print("User Data: \(data)")
                userData = data
                self.setupUI()
            case .failure(let error):
                print("Did not get user data. Error: \(error)")
            }
        }
    }
    private func setupUI(){
        sideMenuBtn.setImage(UIImage(named: "main-menu"), for: .normal)
    
    }
}

// MARK--> TableViewDelegate and Datasources
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        default:
            return 12
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        if indexPath.section == 0 {
            let cell1 = tblView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
           
            cell = cell1
        }else {
            let cell2 = tblView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
            cell = cell2
        }
       
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0  {
            // for search bar
            return 60
        }else {
            return 70
        }
      
    }
}

// MARK--> Cinfirming sideMenuNavigatationDelegate
extension HomeVC: SideMenuDelegate {
     func didSelectSettings() {
         print("Selected Settings VC ")
        let settingsVC = SettingsVC.instantiate()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
