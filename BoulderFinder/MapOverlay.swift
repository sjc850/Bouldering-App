//
//  MapOverlay.swift
//  BoulderFinder
//
//  Created by Shane on 2/1/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MyMapOverlayRenderer: MKOverlayRenderer {
    
    let diameter: Double
    let fillColor: UIColor
    
    init(overlay: MKOverlay, diameter: Double, fillColor: UIColor) {
        
        self.diameter = diameter
        self.fillColor = fillColor
        super.init(overlay: overlay)
        
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        
        let path = UIBezierPath(rect: CGRect(x: mapRect.origin.x, y: mapRect.origin.y, width: mapRect.size.width, height: mapRect.size.height))
        path.usesEvenOddFillRule = true
        let radiusInMapPoints = diameter * MKMapPointsPerMeterAtLatitude(MKMapPointsPerMeterAtLatitude(overlay.coordinate.latitude))
        
        let radiusSquared = MKMapSize(width: radiusInMapPoints, height: radiusInMapPoints)
        
        let regionOrigin = MKMapPointForCoordinate(overlay.coordinate)
        
        var regionRect = MKMapRect(origin: regionOrigin, size: radiusSquared)
        
        regionRect = MKMapRectOffset(regionRect, -radiusInMapPoints / 2, -radiusInMapPoints / 2)
        regionRect = MKMapRectIntersection(regionRect, MKMapRectWorld)
        
        let midX = ( regionOrigin.x + regionRect.origin.x) / 2
        let midY = ( regionOrigin.y + regionRect.origin.y) / 2
        
        let cornerRadius = CGFloat(regionRect.size.width / Double(2))
        let excludePath = UIBezierPath(roundedRect: CGRect(x: midX, y: midY, width: regionRect.size.width / 2, height: regionRect.size.height / 2), cornerRadius: cornerRadius)
        
        path.append(excludePath.reversing())
        
        context.setFillColor(fillColor.cgColor)
        context.addPath(path.cgPath)
        context.fillPath()

}

