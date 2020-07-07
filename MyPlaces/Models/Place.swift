//
//  Place.swift
//  MyPlaces
//
//  Created by Denis Abramov on 26.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

struct Place {
    
    var name: String?
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let restaurantNames = [
        "Burger Records", "Little Kitchen", "Суши Make", "Перчини",
        "Мятный карась", "KANNAM CHICKEN", "Гудман", "Please, Don't stick",
        "Megapolisbar PEOPLE'S", "Respublica", "Хан Буз",
        "Чучвара", "Шафран", "Баранжир", "ШашлыкоFF"
    ]
    
    static func getPlace() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place,
                                location: "Novosibirsk",
                                type: "Restaurant",
                                image: nil,
                                restaurantImage: place))
        }
        return places
    }
}
