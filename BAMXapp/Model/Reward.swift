//
//  Reward.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 01/10/21.
//

import Foundation
import Firebase

struct Reward {
    var id: Int
    var imgURL: URL
    
    let reference: DatabaseReference?
    let key: String
    
    init?(snapshot: DataSnapshot)
    {
        let value = snapshot.value as? [String: AnyObject]
        let id = value?["id"] as? Int
        let urlStr = value?["imgURL"] as? String
        
        self.reference = snapshot.ref
        self.key = snapshot.key
        
        self.id = id!
        self.imgURL = URL(string: urlStr!)!
    }
}
