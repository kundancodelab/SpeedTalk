//
//  SettingsVC.swift
//  SpeedTalk
//
//  Created by User on 04/05/25.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView:UITableView!
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let headerView = tableView.tableHeaderView {
            var frame = headerView.frame
            frame.size.height = 100 // Set the height here
            headerView.frame = frame
        }
    }
    

  private func setupTableView(_ tableView:UITableView){
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
      // Register Header View
      tableView.register(UINib(nibName: "TblViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TblViewHeader")
      
      tableView.backgroundColor = UIColor.clear
      tableView.showsVerticalScrollIndicator = false
      tableView.showsHorizontalScrollIndicator = false
      tableView.sectionHeaderHeight = 0
      setupTableHeader()
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
    }

    //MARK: IBAction
    @IBAction func didtapBackBtn(_ sender: UIButton ) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: UITableView Datasource and Delegate Methods
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
