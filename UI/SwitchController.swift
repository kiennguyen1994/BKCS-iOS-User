//
//  SwitchController.swift
//  UI
//
//  LocationController.swift
//  UI
//
//  Created by kien on 11/25/16.
//  Copyright © 2016 kien. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import CoreLocation
import SwiftMessages
protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: SwitchController, didAddCoordinate coordinate: CLLocationCoordinate2D,
                                        radius: Double, identifier: String, note: String)
}

class SwitchController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: -
    // MARK: Vars
    
    var timer : Timer = Timer()
    
    let locationManager = CLLocationManager()
    var speed : CLLocationSpeed = CLLocationSpeed()
    
    fileprivate var currentCoordiante: CLLocationCoordinate2D?
    
    @IBOutlet weak var SegmentedMaps: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    var ref: FIRDatabaseReference! = nil
    var utenteRef: FIRDatabaseReference! = nil
    var userId = FIRAuth.auth()?.currentUser?.uid    // MARK: -
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = FIRDatabase.database().reference()
       // utenteRef = ref.child("PATH").child(userId!)
         utenteRef = ref.child("PATH").child("KIEN")
        
        let titleButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
        titleButton.setTitle("Live Maps", for: .normal)
        titleButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)
        titleButton.setTitleColor(UIColor.white, for: .normal)
        //titleButton.addTarget(self, action: Selector("titlepressed:"), for: UIControlEvents.touchUpInside)
        self.navigationItem.titleView = titleButton

        
        
        //UIApplication.shared.statusBarStyle = .lightContent
        
        navigationController!.navigationBar.isTranslucent = false
        
        let runkeeperSwitch2 = DGRunkeeperSwitch()
        runkeeperSwitch2.titles = ["OFF", "ON"]
        runkeeperSwitch2.backgroundColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        runkeeperSwitch2.selectedBackgroundColor = .white
        runkeeperSwitch2.titleColor = .white
        runkeeperSwitch2.selectedTitleColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        runkeeperSwitch2.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitch2.frame = CGRect(x: 50.0, y: 10.0, width: view.bounds.width - 100.0, height: 30.0)
        runkeeperSwitch2.autoresizingMask = [.flexibleWidth]
        runkeeperSwitch2.addTarget(self, action: #selector(SwitchController.switchValueDidChange(sender:)), for: .valueChanged)
        view.addSubview(runkeeperSwitch2)
        
        
        }
    
    // MARK: -
    @IBAction func MenuButton(_ sender: Any) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    @IBAction func WhenclickSegmented(_ sender: Any) {
        if (SegmentedMaps.selectedSegmentIndex == 0)
        {
            print("0")
        }
        if (SegmentedMaps.selectedSegmentIndex == 1)
        {
            utenteRef = FIRDatabase.database().reference(fromURL: "https://ios-login-c71ab.firebaseio.com/ALERT")
            utenteRef.observe(.childAdded, with: {snapshot in
                let snapshotaler = snapshot.value as? NSDictionary
                let lat = snapshotaler?["Latitude"] as! CLLocationDegrees
                let long = snapshotaler?["Longitude"] as! CLLocationDegrees
                let annotation = MKPointAnnotation()
                annotation.title = "Report by"
                annotation.subtitle = "Subject: "
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                self.mapView.addAnnotation(annotation)
            })
        }
    }
    
    
    @IBAction func locationUser(_ sender: Any) {
        self.selfset()
    }
  
    @IBAction func switchValueDidChange(sender: DGRunkeeperSwitch!) {
        if (sender.selectedIndex == 1)
        {
            self.selfset()
            self.pushdata()
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureTheme(.error)
            view.configureDropShadow()
            view.configureContent(title: "Alert", body: "Your Location will be collect")
            SwiftMessages.show(view: view)
        }
        if (sender.selectedIndex == 0)
        {
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureTheme(.success)
            view.configureDropShadow()
            view.configureContent(title: "Success", body: "Your report is ready to send")
            SwiftMessages.show(view: view)
            self.locationManager.stopUpdatingLocation()
            timer.invalidate()
        }
    }
    
    func selfset()
    {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
        self.locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(center, MKCoordinateSpanMake(3, 3))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
           }
    
    func collectdata()
    {
        let date = Date();
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        speed = locationManager.location!.speed
        let localDate = dateFormatter.string(from: date as Date)
        utenteRef.child(localDate).setValue(["Latitude": locationManager.location!.coordinate.latitude, "Longitude": locationManager.location!.coordinate.longitude,"Speed":speed * 2.23693629, "Accuracy":locationManager.location!.verticalAccuracy])
    }
    
    func pushdata()
    {
        timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(SwitchController.repeat1), userInfo: nil, repeats: true)
    }
    func repeat1()
    {
        collectdata()
    }

}

extension MKMapView {
    func zoomToUserLocation() {
        guard let coordinate = userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        setRegion(region, animated: true)
    }
}
