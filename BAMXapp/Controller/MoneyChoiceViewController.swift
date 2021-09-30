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
    
    @IBAction func didTapButton(){
//        let paymentMethod = storyboard?.instantiateViewController(identifier: "payment_id") as! PaymentViewController
//        navigationController?.pushViewController(paymentMethod, animated: true)
        UIApplication.shared.open(URL(string: "https://bdalimentos.org/make-a-donation/?cause_id=8492")! as URL, options: [:], completionHandler: nil)
        }

}
