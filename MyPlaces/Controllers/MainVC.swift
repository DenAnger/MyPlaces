//
//  MainVC.swift
//  MyPlaces
//
//  Created by Denis Abramov on 22.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    let restaurantNames = [
        "Burger Records", "Little Kitchen", "Суши Make", "Перчини",
        "Мятный карась", "KANNAM CHICKEN", "Гудман", "Please, Don't stick",
        "Megapolisbar PEOPLE'S", "Respublica", "Хан Буз",
        "Чучвара", "Шафран", "Баранжир", "ШашлыкоFF"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: restaurantNames[indexPath.row])
        cell.imageView?.layer.cornerRadius = cell.frame.size.height / 2
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
