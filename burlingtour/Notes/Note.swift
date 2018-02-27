import Foundation
import UIKit

class Note: NSObject, NSCoding, Favorite {
    var name: String
    var desc: String
    var image: UIImage?
    var type = "note"
    var sectionTitle = "Notes"
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.desc, forKey: "desc")
        coder.encode(self.image, forKey: "image")
    }
    
    init (name: String, desc: String, image: UIImage?) {
        self.name = name
        self.desc = desc
        self.image = image ?? nil
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.desc = decoder.decodeObject(forKey: "desc") as? String ?? ""
        self.image = decoder.decodeObject(forKey: "image") as? UIImage ?? UIImage()
    }
}
