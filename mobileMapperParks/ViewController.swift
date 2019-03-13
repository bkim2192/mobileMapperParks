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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var parksArray:[MKMapItem] = []
    
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        textField.delegate = self
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation){
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        return pin
        
    }
   
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var currentMapItem = MKMapItem()
        if let title = view.annotation?.title, let parkName = title{
            for mapItem in parksArray {
                if mapItem.name == parkName {
                    currentMapItem = mapItem
                }
            }
        }
        let placemark = currentMapItem.placemark
        print(placemark)
        
        if let phoneNumber = currentMapItem.phoneNumber{
            createAlert(phoneNumber)
        }
    }
    
    func createAlert(_ phoneNumber:String){
        let alert = UIAlertController(title: "phone number", message: phoneNumber, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
       var coord = currentLocation.coordinate
        
    }

    @IBAction func whenZoomButtonPressed(_ sender: Any) {
        let center = currentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func whenSearchButtonPressed(_ sender: Any) {
        
        let request = MKLocalSearch.Request()
        if let text = textField.text {
            request.naturalLanguageQuery = "\(text)"
            parksArray.removeAll()
            mapView.reloadInputViews()
        }
        
        
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            //I pressed enter on highlighted(closure)
            guard let response = response else {return}
            // opposite of if let, if there is no data in response, do this.
            for mapItem in response.mapItems {
                self.parksArray.append(mapItem)
                let annotation = MKPointAnnotation()
                //pins on maps are annotation
                annotation.title = mapItem.name
                annotation.coordinate = mapItem.placemark.coordinate
                self.mapView.addAnnotation(annotation)
            //    var annotationArray:[MKAnnotation]
                
                
            }
        }

    }
}

