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

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    
    var loadImgView = UIImageView()
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
    }
    
    

}
