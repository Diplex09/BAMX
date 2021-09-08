//
//  EventCollectionViewCell.swift
//  BAMXapp
//
//  Created by user195828 on 9/8/21.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var donatorsLbl: UILabel!
    
    var event: Event! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d, MMMM, y, HH:mm" //checar formato, pero creo q esta bien...
        
        if event != nil {
            imageViewCell.image = event.eventImage
            titleLbl.text = event.title
            dateLbl.text = dateFormatter.string(from: event.date)
            donatorsLbl.text = "Donadores: " //contar donadores del evento
        }
        else {
            imageViewCell.image = nil
            titleLbl.text = nil
            dateLbl.text = nil
        }
           
        imageViewCell.layer.cornerRadius = 20.0
        imageViewCell.layer.masksToBounds = true
    }
}
