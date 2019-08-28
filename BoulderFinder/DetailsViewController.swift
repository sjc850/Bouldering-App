//
//  DetailsViewController.swift
//  BoulderFinder
//
//  Created by Shane on 1/28/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController:UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField:UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveAction(_ sender: Any) {
        let nameString:String = nameTextField.text!
        let gradeString:String = gradeTextField.text!
        let descriptionString:String = descriptionTextField.text!
        let areaString:String = areaTextField.text!
        
        let newMapPin:MapPin = MapPin(title: nameString, grade: gradeString, area: areaString, imageURL: "", subtitle: descriptionString, coordinate: CLLocationCoordinate2DMake(47.655, -117.455) )
        
        BoulderController.addBoulder(boulder: newMapPin)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
