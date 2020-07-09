//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Denis Abramov on 09.07.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
}
