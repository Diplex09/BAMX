//
//  ProfileCollectionViewCell.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 09/09/21.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var backgroundColorView : UIView!
    @IBOutlet weak var ProfileRecordLabel : UILabel!
    @IBOutlet weak var ProfileRecordNumber : UILabel!
    @IBOutlet weak var ProfileRecordUpdate : UILabel!
    
    
    
    var profileRecord: ProfileRecord! {
        didSet{
            self.updateUI()
        }
    }
    func updateUI() {
        if let profileRecord = profileRecord {
            ProfileRecordLabel.text = profileRecord.title
            ProfileRecordNumber.text = profileRecord.number
            ProfileRecordUpdate.text = profileRecord.date
            backgroundColorView.backgroundColor = profileRecord.color
              
        }else{
            ProfileRecordLabel.text = nil
            ProfileRecordNumber.text = nil
            ProfileRecordUpdate.text = nil
            backgroundColorView.backgroundColor = nil
            
        }
        
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        
    }


}













