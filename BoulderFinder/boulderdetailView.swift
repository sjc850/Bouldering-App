//
//  boulderdetailView.swift
//  BoulderFinder
//
//  Created by Shane on 3/13/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import UIKit

class boulderdetailView: UIView {
    @IBOutlet var contentView: boulderdetailView!
    @IBOutlet weak var Grade: UILabel!
    @IBOutlet weak var boulderDescription: UILabel!
    
    var boulder: MapPin! {
        didSet {
            boulderDescription?.text = boulder.title
            Grade?.text = boulder.grade
        }
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    func commonInit() {
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
    
    }
}
