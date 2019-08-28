//
//  CustomDetailView.swift
//  BoulderFinder
//
//  Created by Shane on 2/26/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import UIKit



class CustomDetailView : UIView {
    @IBOutlet var grade : UILabel!
    @IBOutlet var area: UILabel!

    class func fromNib(owner: Any?) -> CustomDetailView  {

        return Bundle.main.loadNibNamed(
            "CustomDetailView", owner: owner, options: nil)![0] as! CustomDetailView
    }
}
