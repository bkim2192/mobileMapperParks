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
    var parksArray:[MKMapItem] = []
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
        let center = currentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func whenSearchButtonPressed(_ sender: Any) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "parks"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            <#code#>
        }
        //I pressed enter on highlighted(closure)
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
}

