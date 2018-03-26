import Foundation

class Sight: NSObject, NSCoding, Favorite {
    var name: String
    var desc: String
    var emoji: String
    var image: String
    var lat: Double
    var lng: Double
    var type = "sight"
    var sectionTitle = "Sights"
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.desc, forKey: "desc")
        coder.encode(self.emoji, forKey: "emoji")
        coder.encode(self.image, forKey: "image")
        coder.encode(self.lat, forKey: "lat")
        coder.encode(self.lng, forKey: "lng")
    }
    
    init(name: String, desc: String, emoji: String, image: String, lat: Double, lng: Double) {
        self.name = name
        self.desc = desc
        self.emoji = emoji
        self.image = image
        self.lat = lat
        self.lng = lng
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.desc = decoder.decodeObject(forKey: "desc") as? String ?? ""
        self.emoji = decoder.decodeObject(forKey: "emoji") as? String ?? ""
        self.image = decoder.decodeObject(forKey: "image") as? String ?? ""
        self.lat = decoder.decodeObject(forKey: "lat") as? Double ?? 0.0
        self.lng = decoder.decodeObject(forKey: "lng") as? Double ?? 0.0
    }
}
