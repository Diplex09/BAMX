//
//  Event.swift
//  BAMXapp
//
//  Created by user195828 on 9/8/21.
//
import UIKit
import Firebase

struct Event {
    var id: Int
    var title: String
    var description: String?
    var date: Date
    var place: Place //delete? como se sacan datos anidados?
    var latitude: Double
    var longitude: Double
    // var eventImage: UIImage
    var imgURL: String
    
    let reference: DatabaseReference?
    let key: String
    
    init(id: Int, title: String, desc: String, date: Int, longitude: Double, latitude: Double, imgURL: String, snapshot: DataSnapshot) {
        self.reference = snapshot.ref
        self.key = snapshot.key
        
        self.id = id
        self.title = title
        print("Event \(id): \(title)")
        
        self.description = desc
        self.date = Date(timeIntervalSince1970: TimeInterval(date)) // get time from unix epoch to date?
        
        self.latitude = latitude
        self.longitude = longitude
        self.place = Place(latitude: latitude, longitude: longitude)
        
        self.imgURL = imgURL
    }
    
    init?(snapshot: DataSnapshot)
    {
            let value = snapshot.value as? [String: AnyObject]
            let id = value?["id"] as? Int
            let title = value?["title"] as? String
            let description = value?["description"] as? String
            let date = value?["date"] as? Int
            let place = value?["place"] as? [String : Double]
            let imgURL = value?["imgURL"] as? String
        
        self.reference = snapshot.ref
        self.key = snapshot.key
        
        self.id = id!
        self.title = title!
        
        self.description = description!
        self.date = Date(timeIntervalSince1970: TimeInterval(date!)) // get time from unix epoch to date?
        
        self.place = Place(latitude: place!["latitude"]!, longitude: place!["longitude"]!)
        self.latitude = place!["latitude"]!
        self.longitude = place!["longitude"]!
        
        self.imgURL = imgURL!
    }
    
    func toAnyObject() -> Any
    {
        return [
            "id": id,
            "title": title,
            "description": description ?? "",
            "date": date.timeIntervalSince1970, //to Unix epoch for storing in databsse
            "place": ["longitude": longitude,
                      "latitude": latitude],
            "imgURL": imgURL
        ]
    }
}
