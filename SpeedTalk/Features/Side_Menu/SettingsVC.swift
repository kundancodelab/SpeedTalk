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
    var arr_DM_2:[(String, String)] = [("","")]
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setupTableHeader()
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
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        tableView.register(UINib(nibName: "footerCellTableViewCell", bundle: nil), forCellReuseIdentifier: "footerCellTableViewCell")
        // Register Header View
        tableView.register(UINib(nibName: "TblViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TblViewHeader")
        
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
       // tableView.sectionHeaderHeight = 0
        
        tableView.reloadData()
      }
      private func setupTableHeader() {
          guard let headerView = Bundle.main.loadNibNamed("TblViewHeader", owner: nil, options: nil)?.first as? TblViewHeader else {
              print(" Failed to load TblViewHeader")
              return
          }
        
          headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80)
          // Force layout to ensure the header size is correct
              headerView.setNeedsLayout()
              headerView.layoutIfNeeded()

          headerView.onQRCodeTapped = { [weak self] in
              print(" QR Code tapped from VC")
              // Add your navigation or logic
          }

          headerView.onAddAccountTapped = { [weak self] in
              print(" Add Account tapped from VC")
              // Add your navigation or logic
          }

          tableView.tableHeaderView = headerView
          // This forces the table view to update its layout properly
          tableView.layoutIfNeeded()
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
            ("", "Account"),
            ("", "Privacy"),
            ("", "Avatar"),
            ("", "List"),
            ("", "Chats"),
            ("", "Notification"),
            ("", "Storage and data"),
            ("", "App Language"),
            ("", "Help"),
            ("", "Invite a friend"),
            ("", "App Updates")
           
        ]
    }
}
// MARK: UITableView Datasource and Delegate Methods
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arr_DM_2.count
        }else {
            return arr_DM_1.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            cell = cell1
           
        }else {
            let cell2 = self.tableView.dequeueReusableCell(withIdentifier: "footerCellTableViewCell", for: indexPath) as! footerCellTableViewCell
            let data = arr_DM_1[indexPath.row]
            cell2.configureCell(with:data)
            cell = cell2
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }else {
            return 50
        }
      
    }
    
}
