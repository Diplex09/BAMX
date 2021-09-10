//
//  Event.swift
//  BAMXapp
//
//  Created by user195828 on 9/8/21.
//

import UIKit

struct Event {
    var id: String
    var title: String
    var description: String?
    var date: Date
    var place: Site
    var eventImage: UIImage
    
    init(id: String, title: String, description: String, date: Date, place: Site, img: UIImage) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.place = place
        self.eventImage = img
    }
}
