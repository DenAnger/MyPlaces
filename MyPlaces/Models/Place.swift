//
//  Place.swift
//  MyPlaces
//
//  Created by Denis Abramov on 26.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import CoreData

struct Place {
	var name: String?
	var location: String?
	var type: String?
	var imageData: Data?
	var date = Date()
	var rating = 0.0
}
