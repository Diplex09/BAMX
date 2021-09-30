//
//  EventDetailViewController.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 29/09/21.
//

import UIKit
import MapKit
import CoreLocation

class EventDetailViewController: UIViewController {
    
    var event = Event(id: 0, title: " ", description: " ", date: Date(timeIntervalSince1970: TimeInterval()), place: Place(latitude: 0.0, longitude: 0.0), img: UIImage())
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    
    var loadImgView = UIImageView()
    var loadLatitude: Double = 0.0
    var loadLongitude: Double = 0.0
    var titleStr = ""
    var desc = ""
    var dateStr = ""
    var placeStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgView.image = loadImgView.image
        titleLbl.text = titleStr
        descLbl.text = desc
        dateLbl.text = dateStr
        placeLbl.text = placeStr
        
        latitude = loadLatitude
        longitude = loadLongitude
        
        setupPlaceLabelTap()
    }
    
    @objc func placeLabelTapped(_ sender: UITapGestureRecognizer) {
            print("labelTapped")
            let place = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            let mapItem = MKMapItem(placemark: place)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
    }
        
    func setupPlaceLabelTap() {
            
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.placeLabelTapped(_:)))
            self.placeLbl.isUserInteractionEnabled = true
            self.placeLbl.addGestureRecognizer(labelTap)
            
    }

}
