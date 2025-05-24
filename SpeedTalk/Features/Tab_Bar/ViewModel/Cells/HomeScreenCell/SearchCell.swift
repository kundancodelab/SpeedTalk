//
//  SearchCell.swift
//  SpeedTalk
//
//  Created by User on 24/05/25.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var searbarTextfield:UISearchBar!
    var searchText:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searbarTextfield.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}

// MARK:  Search Bar delegates
extension SearchCell : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Clicked")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        resignFirstResponder()
        return true
    }
}
