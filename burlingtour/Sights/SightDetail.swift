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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sight.name
        desc.text = sight.description
        image.image = UIImage(named: sight.image)
        
        //Map init stuff
        let location = CLLocationCoordinate2D(latitude: sight.lat,longitude: sight.lng)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = sight.name
        annotation.subtitle = sight.description
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
