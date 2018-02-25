//
//  Sight.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/24/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import Foundation

class Sight {
    var name: String
    var description: String
    var image: String
    var lat: Double
    var lng: Double
    
    init(name: String, description: String, image: String, lat: Double, lng: Double) {
        self.name = name
        self.description = description
        self.image = image
        self.lat = lat
        self.lng = lng
    }
}
