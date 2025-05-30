//
//  SettingsVC.swift
//  SpeedTalk
//
//  Created by User on 04/05/25.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    var arr_DM_1:[(String, String)] = [("", "")]
    var arr_DM_2:[SideMenuDM?] = [nil]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStaticData()
        setupTableView(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        if let headerView = tableView.tableHeaderView {
//            var frame = headerView.frame
//            frame.size.height = 100 // Set the height here
//            headerView.frame = frame
//        }
//    }
    
    //MARK: IBAction
    @IBAction func didtapBackBtn(_ sender: UIButton ) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Helpter methods for this class.
extension SettingsVC {
    
    private func setupTableView(_ tableView:UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "tblHeaderCell", bundle: nil), forCellReuseIdentifier: "tblHeaderCell")
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        tableView.register(UINib(nibName: "footerCellTableViewCell", bundle: nil), forCellReuseIdentifier: "footerCellTableViewCell")
       
        
        
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
       // tableView.sectionHeaderHeight = 0
        
        tableView.reloadData()
      }
   
    private func loadStaticData() {
        arr_DM_1 = [
            ("instagram", "Open Instagram"),
            ("facebook", "Open Facebook"),
            ("threads", "Open Threads"),
            ("metaai", "Open Meta AI App")
        ]
        
        arr_DM_2  = [
            SideMenuDM(icon: "key", title: "Account", subtitle: "Security notifications,change number"),
            SideMenuDM(icon: "padlock", title: "Privacy", subtitle: "Block con tacts , disappearing messages"),
            SideMenuDM(icon: "hair-style", title: "Avatar", subtitle: "Create, edit,profile photo"),
            SideMenuDM(icon: "people", title: "Lists", subtitle: "A Manage people and grups"),
            SideMenuDM(icon: "chat", title: "Chats", subtitle: "Theme, wallpapers , chat history"),
            SideMenuDM(icon: "notification-bell", title: "Notifications", subtitle: "Message , group & call tones"),
            SideMenuDM(icon: "", title: "Storage and data", subtitle: "Network usage, auto downloaded"),
            SideMenuDM(icon: "globe-earth", title: "App Language", subtitle: "English(devices' language)"),
            SideMenuDM(icon: "question", title: "Help", subtitle: "Help center, contact us, privacy policy"),
            SideMenuDM(icon: "people", title: "Inviate a contact", subtitle: ""),
            SideMenuDM(icon: "mobile-phone", title: "App updates", subtitle: "")
            
           
        ]
    }
}
// MARK: UITableView Datasource and Delegate Methods
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section ==  0 {
            return 1
        }else  if section == 1 {
            return arr_DM_2.count
        }else {
            return 1
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "tblHeaderCell", for: indexPath) as! tblHeaderCell
            cell1.onQRCodeTapped = { [weak self] in
                guard self != nil else {return}
            }
            cell1.onAddAccountTapped = { [weak self] in
                guard self != nil else {return}
            }
        
           
        }else  if indexPath.section == 1 {
            
            let cell2 = self.tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            if  let data = arr_DM_2[indexPath.row] {
                cell2.configureCell(with: data)
            }
            cell = cell2
            
        }else {
           
            let cell3 = self.tableView.dequeueReusableCell(withIdentifier: "footerCellTableViewCell", for: indexPath) as! footerCellTableViewCell
            let data = arr_DM_1[indexPath.row]
            cell3.configureCell(with:arr_DM_1)
            cell = cell3
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }else if indexPath.section == 1 {
            return 80
        }else {
            return 220
        }
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.animateWithBounceFadeAndBackground {
                let profileVC = ProfileVC.instantiate()
                self.navigationController?.pushViewController(profileVC, animated: true)
            }
         
        }
    }
    
}
