//
//  EventDetailViewController.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 29/09/21.
//

import UIKit
import MapKit
import CoreLocation
import EventKit

class EventDetailViewController: UIViewController {
    
    var event = Event(id: 0, title: " ", description: " ", date: Date(timeIntervalSince1970: TimeInterval()), place: Place(latitude: 0.0, longitude: 0.0), img: UIImage())
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    let eventStore : EKEventStore = EKEventStore()

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
        imgView.contentMode = .scaleAspectFill
        titleLbl.text = titleStr
        descLbl.text = desc
        dateLbl.text = dateStr
        placeLbl.text = placeStr
        
        latitude = loadLatitude
        longitude = loadLongitude
    }
    
    //TODO: Add event to iOS Calendar
    @IBAction func didTapAddToCalendar(_ sender: Any) {
        print("adding to calendar...")
        var flag = false
        eventStore.requestAccess(to: .event) { (granted, error) in
          
          if (granted) && (error == nil) {
              print("granted \(granted)")
            print("error \(String(describing: error))")
              
            let calendarEvent:EKEvent = EKEvent(eventStore: self.eventStore)
              
            calendarEvent.title = "BAMX: " + self.event.title
            calendarEvent.startDate = self.event.date
            calendarEvent.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: self.event.date)
            calendarEvent.notes = "Evento del Banco de Alimentos de Guadalajara\n\n" + self.event.description!
            calendarEvent.calendar = self.eventStore.defaultCalendarForNewEvents
              do {
                try self.eventStore.save(calendarEvent, span: .thisEvent)
                    flag = true
              } catch let error as NSError {
                  print("failed to save event with error : \(error)")
              }
              print("Saved Event")
                
          }
          else{
          
              print("failed to save event with error : \(error) or access not granted")
          }
        }
        
        if(flag)
        {
            let alert = UIAlertController(
                title: "Evento añadido",
                message:  "El evento ha sido añadido a tu calendario ¡Nos vemos pronto!", // error?.localizedDescription,
                preferredStyle: .alert
            )
        
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapShowDirections(_ sender: Any) {
        print("Opening direcitons in Apple Maps...")
        let place = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        let mapItem = MKMapItem(placemark: place)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    @IBAction func didTapDonate(_sender: Any){
        let cvc = storyboard?.instantiateViewController(identifier: "NV_ID") as! UINavigationController
        present(cvc, animated: true)
    }
    
    
}
