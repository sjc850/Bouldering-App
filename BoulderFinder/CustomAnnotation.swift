//
//  CustomAnnotation.swift
//  BoulderFinder
//
//  Created by Shane on 2/17/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import MapKit
import Alamofire

extension ViewController: MKMapViewDelegate {
    
                // Annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print ("view")
        guard let annotation = view.annotation as? MapPin
            else {return}
        loadImage(for: annotation, view: view)
    }
    
    func loadImage(for annotation: MapPin, view: MKAnnotationView){
        guard let imageURL = annotation.imageURL else {return}
        if annotation.image != nil {
            return
        }
        Alamofire.request(imageURL).responseData{response in
            if let imageData = response.result.value{
                print ("Load image")
                let image = UIImage(data: imageData)
                annotation.image = image
                let imageView = UIImageView (image: image)
                imageView.frame.size.width = 200
                imageView.frame.size.height = 200
                view.leftCalloutAccessoryView = imageView
                view.setNeedsDisplay()
            }
        }
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        /// MapPin is the overall 
        if let annotation = annotation as? MapPin {
            let identifier = "pin"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? AnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                // Callout
                view = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                if let gradeString = annotation.grade{
                    if let grade = Int(gradeString.substring(from: gradeString.index(gradeString.startIndex, offsetBy: 1))) {
                        switch grade {
                        case 0...2:
                            view.image=#imageLiteral(resourceName: "EasyPin")
                        case 3...5:
                            view.image=#imageLiteral(resourceName: "ModeratePin")
                        case 6...8:
                            view.image=#imageLiteral(resourceName: "UpperModeratePin")
                        case 9...12:
                            view.image=#imageLiteral(resourceName: "HardPin")
                        default:
                            view.image=#imageLiteral(resourceName: "pixexample")
                        }
                    }
                }
                
                // Left Accessory
                let leftAccessory = UILabel(frame: CGRect(x: 0,y: 0,width: 10,height: 30))
                leftAccessory.text = annotation.title
                leftAccessory.font = UIFont(name: "name", size: 8)
                //view.addSubview(leftAccessory)
                
            }
            return view
        }
            return nil
        }
}


extension UIImage {
    class func circle(withRadius radius: CGFloat, color: UIColor) -> UIImage {
        let diameter = 2 * radius
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: diameter, height: diameter), false, 0)
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        let path = UIBezierPath(ovalIn: rect)
        color.setFill()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


