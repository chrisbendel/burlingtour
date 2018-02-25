//
//  Sight.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/24/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import Foundation

class Sight: NSObject, NSCoding {
    var name: String
    var desc: String
    var image: String
    var lat: Double
    var lng: Double
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.desc, forKey: "description")
        coder.encode(self.image, forKey: "image")
        coder.encode(self.lat, forKey: "lat")
        coder.encode(self.lng, forKey: "lng")
    }
    
    init(name: String, description: String, image: String, lat: Double, lng: Double) {
        self.name = name
        self.desc = description
        self.image = image
        self.lat = lat
        self.lng = lng
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.desc = decoder.decodeObject(forKey: "description") as? String ?? ""
        self.image = decoder.decodeObject(forKey: "image") as? String ?? ""
        self.lat = decoder.decodeObject(forKey: "lat") as? Double ?? 0.0
        self.lng = decoder.decodeObject(forKey: "lng") as? Double ?? 0.0
    }


}
