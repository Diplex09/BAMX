//
//  EventCollectionViewCell.swift
//  BAMXapp
//
//  Created by user195828 on 9/8/21.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseStorageUI

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var donatorsLbl: UILabel!
    
    var event: Event! {
        didSet {
            self.updateUI()
        }
    }
    
    public func configure(with event: Event, imageRef: StorageReference) {
        titleLbl.text = event.title
        
        let placeholderImg = UIImage(named: "bamx-logo.png")
        imageViewCell.sd_setImage(with: imageRef, placeholderImage: placeholderImg)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d, MMMM, y, HH:mm" //dia sem (Lun), dia, mes, año, hora::min
        //checar formato, pero creo q esta bien...
        dateLbl.text = dateFormatter.string(from: event.date)
        donatorsLbl.text = "0" //meter contador de donadores para evento...
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
           
        //imageViewCell.layer.cornerRadius = 20.0
        //imageViewCell.layer.masksToBounds = true
    }
}
