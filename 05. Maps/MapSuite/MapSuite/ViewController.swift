//
//  ViewController.swift
//  MapSuite
//
//  Created by nirahurk on 7/26/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

        @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let locationPlaceMark =  CLPlacemark()
    var placeMarksString = ""
    var placeMarksInfoLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let eiffelTowerLocation = CLLocationCoordinate2D(latitude: 48.8582, longitude: 2.2945)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let mapRegion = MKCoordinateRegion(center: eiffelTowerLocation, span: mapSpan)
        
        mapView.setRegion(mapRegion, animated: true)
        
        let eiffelTowerAnnotation = MKPointAnnotation()
        eiffelTowerAnnotation.coordinate = eiffelTowerLocation
        eiffelTowerAnnotation.title = "The Eiffel Tower"
        eiffelTowerAnnotation.subtitle = "Paris, France"
        
        //location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        mapView.addAnnotation(eiffelTowerAnnotation)
        
        //placemark labe properties
        placeMarksInfoLabel.frame = CGRect(x: 38, y: 100, width: 300, height: 200)
        placeMarksInfoLabel.backgroundColor = UIColor.orange
        placeMarksInfoLabel.layer.borderWidth = 1.0
        placeMarksInfoLabel.layer.borderColor = UIColor.blue.cgColor
        placeMarksInfoLabel.layer.cornerRadius = 8.0
        placeMarksInfoLabel.textAlignment = NSTextAlignment.center
        placeMarksInfoLabel.numberOfLines = 6
        placeMarksInfoLabel.isHidden = true
        self.view.addSubview(placeMarksInfoLabel)
        
    }


    func viewFor(_mapView: MKMapView!, viewFor annotation: MKAnnotation!)-> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinReuseID = "thePin"
        var myPinView = mapView.dequeueReusableAnnotationView(withIdentifier: pinReuseID) as? MKPinAnnotationView
        if myPinView == nil {
            myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinReuseID)
            myPinView!.canShowCallout = true
            myPinView!.animatesDrop = true
            myPinView!.pinTintColor = UIColor.orange
            
        }
        else{
            myPinView!.annotation = annotation
        }
        return myPinView!
        
        
    }
    
    
    

    @IBAction func changeMapType(_ segmentor: UISegmentedControl) {
        
        switch segmentor.selectedSegmentIndex{
        case 0: mapView.mapType = MKMapType.standard
        case 1: mapView.mapType = MKMapType.satellite
        default: mapView.mapType = MKMapType.hybrid
        }
    }
    
    
    @IBAction func showMyLocation(_ sender: Any) {
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarksArray,error) -> Void in
            if let anError = error as? NSError {
                print("ERROR! Here it is" + anError.description)
                return
            }
            if let placeMark = placemarksArray?.first{
                self.stringifyLocationInfo(placeMark)
            }else {
                print("Error with placemark data!")
            }
            let ourLocation = CLLocationCoordinate2DMake(manager.location!.coordinate.latitude,manager.location!.coordinate.longitude )
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let mapRegion = MKCoordinateRegion(center: ourLocation, span: mapSpan)
            self.mapView.setRegion(mapRegion, animated: true)
            
        })
    }
    
    func stringifyLocationInfo(_ placemark:CLPlacemark){
        placeMarksString = "Locality: \(placemark.locality!)\n" + "Zip Code: \(placemark.postalCode!)\n" + "Country: \(placemark.country!)\n" +
        "Latitude/Longitude: (\(placemark.location!.coordinate.latitude),\(placemark.location!.coordinate.longitude))\n"
    }
    
    @IBAction func showPlacemarks(_ sender: Any) {
        if placeMarksInfoLabel.isHidden {
            placeMarksInfoLabel.text = placeMarksString
            placeMarksInfoLabel.isHidden = false
        
        }else{
            placeMarksInfoLabel.isHidden = true
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

