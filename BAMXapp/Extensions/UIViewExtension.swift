//
//  UIViewExtension.swift
//  BAMXapp
//
//  Created by user195828 on 9/7/21.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
