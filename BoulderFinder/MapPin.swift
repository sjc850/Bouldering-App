//
//  MapPin.swift
//  BoulderFinder
//
//  Created by Shane on 1/20/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import MapKit
import Alamofire

class MapPin: NSObject, MKAnnotation {
    
    var image: UIImage?
    
    var title: String?
    var imageURL: String?
    var grade: String?
    var area: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, grade:String, area:String, imageURL:String, subtitle:String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.imageURL = imageURL
        self.grade = grade
        self.area = area
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
