  
//
//  Place.swift
//  BAMXapp
//
//  Created by user195828 on 9/9/21.
//
import Foundation

struct Place: Codable{
    var latitude: Double
    var longitude: Double
    var title: String?
    var address: String?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.title = ""
        self.address = ""
    }
    
    init(latitude: Double, longitude: Double, title: String, address: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.address = address
    }
}
