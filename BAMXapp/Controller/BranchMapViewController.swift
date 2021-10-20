//
//  BranchMapViewController.swift
//  BAMXapp
//
//  Created by Alonso Garcia on 19/10/21.
//

import UIKit
import MapKit
import CoreLocation

class BranchMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let places =  [
        Place(latitude: 20.656161, longitude: -103.355369, title: "Banco de Alimentos Guadalajara", address: "Calle Pichónn 147, Morelos, Guadalajara JAL 44910"),
        Place(latitude: 20.734351, longitude: -103.455281, title: "Tecnológico de Monterrey - Guadalajara Campus", address: "Avenida Ramón Corona 2514, Los Olivos, Zapopan JAL 45207")
    ]
    
    var selectedPin: MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        addAnnotations(places: places)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.showsTraffic = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotations(places: [Place]){
        
        for place in places {
            let coords = CLLocation(latitude: place.latitude, longitude: place.longitude)
            
            let CLLCoordType = CLLocationCoordinate2D(latitude: coords.coordinate.latitude,
                                                      longitude: coords.coordinate.longitude)
            
            let marker = MKPointAnnotation()
            marker.coordinate = CLLCoordType
            marker.title = place.title
            marker.subtitle = place.address
            
            self.mapView.addAnnotation(marker);
        }
    }
}

extension BranchMapViewController {
    @objc func getDirections(coords: CLLocationCoordinate2D) {
        print("Getting directions...")
        var pm = MKPlacemark(coordinate: coords)
        let mapItem = MKMapItem(placemark: pm)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
        print("Opening in Maps...")
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        
        pinView?.tintColor = UIColor(named: "bamx-red")
        pinView?.canShowCallout = true
        
        /*let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 60 , height: 50)))
        
        button.setBackgroundImage(UIImage(systemName: "car"), for: .normal)
        
        button.addTarget(self, action: #selector(self.getDirections), for: .touchUpInside)
        
        pinView?.leftCalloutAccessoryView = button*/
        
        return pinView
    }
}
