import Foundation

class Tour: NSObject, NSCoding, Favorite {
    
    var name: String
    var desc: String
    var emoji: String
    var url: String
    var type = "tour"
    var sectionTitle = "Tours"
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.desc, forKey: "desc")
        coder.encode(self.emoji, forKey: "emoji")
        coder.encode(self.url, forKey: "url")
    }
    
    init(name: String, desc: String, emoji: String, url: String) {
        self.name = name
        self.desc = desc
        self.emoji = emoji
        self.url = url
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.desc = decoder.decodeObject(forKey: "desc") as? String ?? ""
        self.emoji = decoder.decodeObject(forKey: "emoji") as? String ?? ""
        self.url = decoder.decodeObject(forKey: "url") as? String ?? ""
    }
}
