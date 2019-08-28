//
//  TableViewController.swift
//  BoulderFinder
//
//  Created by Shane on 1/25/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import UIKit

enum selectedScope: Int {
    case Name = 0
    case Grade = 1
    case Area  = 2
}

class TableViewController: UITableViewController, UISearchBarDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetup()
    
        NotificationCenter.default.addObserver(forName: BoulderController.BOULDER_ADDED_NOTIFICATION, object: nil, queue: nil) { notification in self.tableView.reloadData()
        }
    }
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x:0,y:0, width:(UIScreen.main.bounds.width), height:70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name", "Grade", "Area"]
        
        
        searchBar.delegate = self
        
        self.tableView.tableHeaderView = searchBar
    
    }
    
/*    //MARK - SEARCH BAR DELEGATE - DOESN'T WORK
     
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String){
        filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
    }
  
    
   func filterTableView(ind:Int, text:String) {
        switch ind {
        case selectedScope.Name.rawValue:
            MapPin = MapPin.filter({(boulder) -> Bool in
                    return boulder.imageName.lowercased().contains(text.lowercased())
                })
            
        case selectedScope.Grade.rawValue:
            MapPin = MapPin.filter({(boulder) -> Bool in
                return boulder.imageGrade.lowercased().contains(text.lowercased())
            })
            
            
        case selectedScope.Area.rawValue:
            MapPin = MapPin.filter({(boulder) -> Bool in
                return boulder.imageArea.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print ("Nothing")
        }
    } */
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "detailSegue", sender: nil)
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BoulderController.sharedBoulders().count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let boulderArray:Array = BoulderController.sharedBoulders()
        let boulder:MapPin = boulderArray[indexPath.row] as! MapPin
        
        cell.textLabel?.text = boulder.title
        cell.detailTextLabel?.text = boulder.grade
        cell.imageView?.image = boulder.image
        
        return cell
        }
    }
