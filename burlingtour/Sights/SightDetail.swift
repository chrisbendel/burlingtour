//
//  SightDetail.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/24/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit
import MapKit

class SightDetail: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var desc: UILabel!
    
    var sight: Sight!
    var favoriteSights: [Sight]!
    
    func getFavoritePath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteSights").path)
        }
        
        return filePath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favorites: [Sight] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath()) as? [Sight] {
            self.favoriteSights = favorites
            if favoriteSights.first(where: {$0.name == sight.name}) != nil {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "UnFavorite", style: .plain, target: self, action: #selector(unfavorite))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
            }
        } else {
            self.favoriteSights = [Sight]()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
        }
        
        self.title = sight.name
        desc.text = sight.desc
        image.image = UIImage(named: sight.image)
        
        //Map init stuff
        let location = CLLocationCoordinate2D(latitude: sight.lat, longitude: sight.lng)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = sight.name
        annotation.subtitle = sight.desc
        map.addAnnotation(annotation)
    }
    
    @objc func favorite() {
        self.favoriteSights.append(self.sight)
        NSKeyedArchiver.archiveRootObject(self.favoriteSights, toFile: self.getFavoritePath())
        self.viewDidLoad()
    }
    
    @objc func unfavorite() {
        self.favoriteSights = self.favoriteSights.filter {$0.name != sight.name}
        NSKeyedArchiver.archiveRootObject(self.favoriteSights, toFile: self.getFavoritePath())
        self.viewDidLoad()
    }
}
