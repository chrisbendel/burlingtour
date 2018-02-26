//
//  NoteCell.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/25/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
