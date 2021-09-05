//
//  Item.swift
//  BAMXapp
//
//  Created by user195828 on 9/4/21.
//

import Foundation

struct Item{
    let id: String
    let name: String
    let quantity: Int
    
    init(id: String, name: String, quantity: Int)
    {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
}
