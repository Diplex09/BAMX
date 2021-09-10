//
//  MoneyChoiceViewController.swift
//  BAMXapp
//
//  Created by Mar Mendoza on 08/09/21.
//

import UIKit

class MoneyChoiceViewController: UIViewController {
    
    @IBOutlet weak var moneyPreset: UIView!
    @IBOutlet weak var equivalentOptions: UIView!

    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func switchViews (_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            moneyPreset.alpha = 1
            equivalentOptions.alpha = 0
        }else {
            moneyPreset.alpha = 0
            equivalentOptions.alpha = 1
        }
    }

}
