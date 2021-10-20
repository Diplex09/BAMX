//
//  Donation.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 20/10/21.
//

import UIKit
import Firebase

struct Donation {
    var id: Int
    var date: Date
    var name: String
    var location: String
    
    init(id: Int, date: Date, name: String, location: String)
    {
        self.id = id
        self.date = date
        self.name = name
        self.location = location
    }
}
