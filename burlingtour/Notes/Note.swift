//
//  Note.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/25/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import Foundation
import UIKit

class Note: NSObject, NSCoding {
    var name: String
    var text: String
    var image: UIImage?
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.text, forKey: "text")
        coder.encode(self.image, forKey: "image")
    }
    
    init (name: String, text: String, image: UIImage?) {
        self.name = name
        self.text = text
        self.image = image ?? nil
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.text = decoder.decodeObject(forKey: "text") as? String ?? ""
        self.image = decoder.decodeObject(forKey: "image") as? UIImage ?? nil
    }
}
