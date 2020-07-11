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
            
    convenience init(name: String,
                     location: String?,
                     type: String?,
                     imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
