//
//  Site.swift
//  BAMXapp
//
//  Created by user195828 on 9/9/21.
//

import Foundation

struct Site: Codable{
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
