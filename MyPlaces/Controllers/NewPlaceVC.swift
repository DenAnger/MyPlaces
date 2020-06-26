//
//  NewPlaceVC.swift
//  MyPlaces
//
//  Created by Denis Abramov on 26.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

class NewPlaceVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }
}

// MARK: - Text field delegate

extension NewPlaceVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
