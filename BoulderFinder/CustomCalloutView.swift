//
//  CustomClass.swift
//  BoulderFinder
//
//  Created by Shane on 2/22/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import MapKit

class AnnotationView: MKAnnotationView {
    
    var imageView: UIImageView? {
        guard let annotation = self.annotation as? MapPin else {return nil}
        guard let image = annotation.image else {return nil}
        
        let imageView = UIImageView(image:image)
        return imageView
    }
    
    private var detailView: CustomDetailView!
    
    override var annotation: MKAnnotation?{
        didSet{updateDetailText(using: annotation)}
    }

    
    func updateDetailText (using annotation: MKAnnotation?){
        if detailView == nil {return}
        if let annotation = annotation as? MapPin {
            detailView.grade.text = annotation.grade
            detailView.area.text = annotation.subtitle
            }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        detailView = CustomDetailView.fromNib(owner: self)
        updateDetailText(using: annotation)
        detailView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        detailCalloutAccessoryView = detailView
        // detailView Callout = AccessoryView(image:image)(MKannotation)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
