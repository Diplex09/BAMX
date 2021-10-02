//
//  RewardCollectionViewCell.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 01/10/21.
//

import UIKit

class RewardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var  rewardImgView: UIImageView!
    
    func setup(_ reward: Reward) {
        rewardImgView.load(url: reward.imgURL)
    }
}
