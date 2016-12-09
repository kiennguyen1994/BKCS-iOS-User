//
//  SearchLocation.swift
//  UI
//
//  Created by kien on 9/29/16.
//  Copyright © 2016 kien. All rights reserved.
//

import Foundation
import UIKit


class SearchLocation: UIViewController , UISearchBarDelegate {
    

    
    @IBOutlet weak var googleMapsContainer: UIView!
    var resultsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
            }
    
/*    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        
        
    }*/
    
    

    
    @IBAction func getlatlong(_ sender: AnyObject) {
     
                
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    }
