//
//  Service.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 20/10/21.
//



import UIKit
import Firebase

class Service {
    static func createAlertController(title: String, message: String) -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(okAction)
            
            return alert
        }
}
