//
//  FoodDonation.swift
//  BAMXapp
//
//  Created by user195828 on 9/4/21.
//

import Foundation
import Firebase

struct FoodDonation
{
    let reference: DatabaseReference
    let key: String
    let id: String
    let user_id: String
    var items: [Item]
    let date: Date
    
    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value["id"] as? String,
            let user_id = value["user_id"] as? String,
            let items = value["items"] as? [Item],
            let date = value["date"] as? Date
        else
        {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        
        self.id = id
        self.user_id = user_id
        self.items = items
        self.date = date
    }
    
    func toAnyObject() -> Any
    {
        return [
            "id": id,
            "user_id": user_id,
            "items": items,
            "date": date
        ]
    }
}
