import UIKit

// Our link cell, just a name
class LinkTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
