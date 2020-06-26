//
//  MainVC.swift
//  MyPlaces
//
//  Created by Denis Abramov on 22.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    let places = Place.getPlace()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! CustomCell
        
        cell.nameLabel?.text = places[indexPath.row].name
        cell.locationLabel?.text = places[indexPath.row].location
        cell.typeLabel?.text = places[indexPath.row].type
        
        cell.imageOfPlace?.image = UIImage(named: places[indexPath.row].image)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        
        return cell
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
    }
}
