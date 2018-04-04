import UIKit

class SightCell: UITableViewCell  {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    var item: Sight? {
        didSet {
            guard let item = item else {
                return
            }
            self.emoji?.text = item.emoji
            self.name?.text = item.name
            self.desc?.text = item.desc
        }
    }
}
