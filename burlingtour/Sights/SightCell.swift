import UIKit

class SightCell: UITableViewCell  {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var item: Sight? {
        didSet {
            guard let item = item else {
                return
            }
            
            self.name?.text = item.name
            self.desc?.text = item.desc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
