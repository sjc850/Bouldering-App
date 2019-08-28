//
//  ViewController.swift
//  BoulderFinder
//
//  Created by Shane on 1/20/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(forName: BoulderController.BOULDER_ADDED_NOTIFICATION, object: nil, queue: nil) { notification in
            
            let newBoulderPin:MapPin = notification.object as! MapPin
            
            self.mapView.delegate = self
            self.mapView.addAnnotation(newBoulderPin)
            self.mapView.showsCompass = true
            self.mapView.showsScale = true
            
        }
        
        let distanceSpan:CLLocationDegrees = 45000
        let mcClellanLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(47.7, -117.5)
        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(mcClellanLocation, distanceSpan, distanceSpan), animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }

    }
