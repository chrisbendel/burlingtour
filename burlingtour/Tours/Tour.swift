import Foundation

class Tour: NSObject, NSCoding {
    var name: String
    var desc: String
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.desc, forKey: "desc")
    }
    
    init(name: String, desc: String) {
        self.name = name
        self.desc = desc
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.desc = decoder.decodeObject(forKey: "desc") as? String ?? ""
    }
    
    
}
