//
//  OnboardingCollectionViewCell.swift
//  BAMXapp
//
//  Created by user195828 on 9/7/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescLbl: UILabel!
    
    func setup(_ slide: IntroSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescLbl.text = slide.description
    }
}
