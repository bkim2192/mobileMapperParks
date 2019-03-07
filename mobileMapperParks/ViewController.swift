//
//  ViewController.swift
//  mobileMapperParks
//
//  Created by Brandon Kim on 3/6/19.
//  Copyright © 2019 Brandon Kim. All rights reserved.
//

import UIKit
import MapKit

//Packages
//More would take up a lot of space

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
    }
    // func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        // It can track when a user has left a certain area or radius.
   // }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
       var coord = currentLocation.coordinate
        print(coord)
        
    }

    @IBAction func whenZoomButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func whenSearchButtonPressed(_ sender: Any) {
    }
    
    
    
    
    
}

