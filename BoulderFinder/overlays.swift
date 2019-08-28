//
//  overlays.swift
//  BoulderFinder
//
//  Created by Shane on 2/1/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import MapKit

class Map {
    
    func setup() {
        // Assign delegate here. Can call the circle at startup, or at a later point using the method below. Includes <# #> syntax to simplify code completion.
        self.mapView.delegate = self
        showCircle(coordinate: <#CLLocationCoordinate2D#>, radius: <#CLLocationDistance#>)
    }
    
    // Radius is measured in meters
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate, radius: radius)
        self.mapView.addOverlay(circle)
    }
}

extension Map: MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        // If you want to include other shapes, then this check is needed. If you only want circles, then remove it.
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = UIColor.blackColor
            circleRenderer.alpha = 0.1
            
            return circleRenderer
        }
        
        // You can either return your square here, or ignore the circle check and only return circles.
        return <#Another overlay type#>
    }
}
