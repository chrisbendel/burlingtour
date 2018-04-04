import UIKit
import AVFoundation
import AVKit

class TourDetail: UIViewController {

    var player: AVPlayer!
    var favoriteTours: [Tour]!
    var tour: Tour!
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var desc: UILabel!
    
    // load and detect favorites
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tour.name
        self.desc.text = tour.desc
        
        if let favorites: [Tour] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath()) as? [Tour] {
            self.favoriteTours = favorites
            if favoriteTours.first(where: {$0.name == tour.name}) != nil {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "UnFavorite", style: .plain, target: self, action: #selector(unfavorite))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
            }
        } else {
            self.favoriteTours = [Tour]()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
        }
    }
    
    // favorite buttons funcs
    @objc func favorite() {
        self.favoriteTours.append(tour)
        NSKeyedArchiver.archiveRootObject(self.favoriteTours, toFile: self.getFavoritePath())
        self.viewDidLoad()
    }
    
    @objc func unfavorite() {
        self.favoriteTours = self.favoriteTours.filter {$0.name != tour.name}
        NSKeyedArchiver.archiveRootObject(self.favoriteTours, toFile: self.getFavoritePath())
        self.viewDidLoad()
    }

    
    func getFavoritePath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteTours").path)
        }
        
        return filePath
    }
    
    // Media
    @IBAction func playMedia(_ sender: Any) {
        let player = AVPlayer(url: URL(string: tour.url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
