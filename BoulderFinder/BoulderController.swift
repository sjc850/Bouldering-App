//
//  BoulderController.swift
//  BoulderFinder
//
//  Created by Shane on 1/25/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import CoreData
import MapKit

class BoulderController:NSObject {
    
    public static let BOULDER_ADDED_NOTIFICATION = NSNotification.Name("BOULDER_ADDED")
    
    
    static let boulderPinClassName:String = String(describing: MapPinxcdata.self)
    static var boulderArray:Array = Array<MapPin>()
    
    class func sharedBoulders() -> Array<Any>{
        return boulderArray
    }
    
    class func addBoulder( boulder:MapPin){
        if ( boulderArray == nil ) {
            boulderArray = Array<MapPin>()
        }
        BoulderController.boulderArray.insert(boulder, at: 0)
        

            
        NotificationCenter.default.post(name: NSNotification.Name("BOULDER_ADDED"), object: boulder)
    }
    
    class func loadBoulders(){
        Alamofire.request("https://s3-us-west-2.amazonaws.com/boulders/boulderlistPICS4_5.json").responseString { response in
            do{
                let jsonString = response.result.value!
                let jsonData = jsonString.data(using: .utf8)!
                let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as!
                NSArray
                
                for(_, jsonObject) in jsonArray.enumerated(){
                    let currentBoulder:Dictionary = jsonObject as! Dictionary<String, AnyObject>
                    
                    let NAME_KEY = "name"
                    let IMAGE_KEY = "image"
                    let GRADE_KEY = "grade"
                    let AREA_KEY = "area"
                    let LOCATION_KEY = "location"
                    let DESCRIPTION_KEY = "description"
                    let LATITUDE_KEY = "latitude"
                    let LONGITUDE_KEY = "longitude"
                    
                    let nameString:String = currentBoulder[NAME_KEY] as! String
                    let gradeString:String = currentBoulder[GRADE_KEY] as! String
                    let areaString:String = currentBoulder[AREA_KEY] as! String
                    let imageURLString:String = currentBoulder[IMAGE_KEY] as! String
                    let descriptionString:String = currentBoulder[DESCRIPTION_KEY] as! String
                    let locationDictionary:Dictionary = currentBoulder[LOCATION_KEY] as! Dictionary<String, Double>
                    let latitude:Double = locationDictionary[LATITUDE_KEY]! as Double
                    let longitude:Double = locationDictionary[LONGITUDE_KEY]! as Double
                    
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    let currentMapPin:MapPin = MapPin(title: nameString, grade: gradeString, area: areaString, imageURL: imageURLString, subtitle: descriptionString, coordinate: location)
                    
                    BoulderController.addBoulder(boulder: currentMapPin)
                    
                }
            }
            catch{
                print("error")
            }
        }
        
        print("called Alamofire")
        
    }
}
