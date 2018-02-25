import Foundation

class Tour {
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

