//
//  ProfileRecord.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 09/09/21.
//

import UIKit

class ProfileRecord{
    var title : String
    var number : String
    var date : String
    var color: UIColor
    
    init(title:String, number:String, date:String, color:UIColor ){
        self.title = title
        self.number = number
        self.date = date
        self.color = color
    }
    //dummy data
    static func fetchProfileRecords() -> [ProfileRecord]{
        return [ProfileRecord(title:"Donaciones", number:"500", date:"Ultima actualizacion 5d", color: UIColor(red: 0.92, green: 0.59, blue: 0.58, alpha: 1.00)),
            ProfileRecord(title: "Eventos", number: "6", date: "Ultima actualizacion 3d", color: UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)),
            ProfileRecord(title: "interacciones", number: "6", date: "Ultima actualizacion 3d", color: UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)),
            ProfileRecord(title: "Otro", number: "6", date: "Ultima actualizacion 3d", color: UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00))
        ]
    }
    
    
}
