//
//  Note.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/25/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import Foundation
import UIKit

class Note {
    var name: String
    var text: String
    var image: UIImage!
    
    init (name: String, text: String, image: UIImage?) {
        self.name = name
        self.text = text
        self.image = image ?? nil
    }
    
}
