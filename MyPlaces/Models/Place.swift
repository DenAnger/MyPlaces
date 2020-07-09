//
//  Place.swift
//  MyPlaces
//
//  Created by Denis Abramov on 26.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    let restaurantNames = [
        "Burger Records", "Little Kitchen", "Суши Make", "Перчини",
        "Мятный карась", "KANNAM CHICKEN", "Гудман", "Please, Don't stick",
        "Megapolisbar PEOPLE'S", "Respublica", "Хан Буз",
        "Чучвара", "Шафран", "Баранжир", "ШашлыкоFF"
    ]
    
    func savePlaces() {
        
        for place in restaurantNames {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            
            let newPlace = Place()
            
            newPlace.name = place
                newPlace.location = "Novosibirsk"
                    newPlace.type = "Restaurant"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }
    }
}
