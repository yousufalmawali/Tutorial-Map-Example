//
//  ViewController.swift
//  MapEdit
//
//  Created by Yousuf A Almawli on 18/10/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    // location manager to access location functionalities
    let locationManager = CLLocationManager()
    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.first {
            manager.stopUpdatingLocation()
            
            let cordinate = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            let region = MKCoordinateRegion(center: cordinate, span: span)
            myMap.setRegion(region, animated: true)
            
            let myPin = MKPointAnnotation()
            myPin.coordinate = cordinate
            myPin.title = "I am here"
            myPin.subtitle = "I am best hehehe"
            myMap.addAnnotation(myPin)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

