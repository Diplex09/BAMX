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
    @IBOutlet var currentValueField: UITextField!
    
    @IBOutlet var btn100: UIButton!
    @IBOutlet var btn200: UIButton!
    @IBOutlet var btn500: UIButton!
    @IBOutlet var btn1000: UIButton!
    
    //Equivalent table btns
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    
    var moneyValue: Int = 0

    

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
    
    func resetColor(){
        
        btn100.backgroundColor = .white
        btn100.setTitleColor(.black, for: .normal)
        
        btn200.backgroundColor = .white
        btn200.setTitleColor(.black, for: .normal)
        
        btn500.backgroundColor = .white
        btn500.setTitleColor(.black, for: .normal)

        btn1000.backgroundColor = .white
        btn1000.setTitleColor(.black, for: .normal)
        
    }
    
    func resetColorEquivalent(){
        btn1.backgroundColor = .white
        btn1.setTitleColor(.systemYellow, for: .normal)
        
        btn2.backgroundColor = .white
        btn2.setTitleColor(.systemYellow, for: .normal)
        
        btn3.backgroundColor = .white
        btn3.setTitleColor(.systemYellow, for: .normal)
        
        btn4.backgroundColor = .white
        btn4.setTitleColor(.systemYellow, for: .normal)
        
        btn5.backgroundColor = .white
        btn5.setTitleColor(.systemYellow, for: .normal)
    }
    
    @IBAction func didTapButton(){
//        let paymentMethod = storyboard?.instantiateViewController(identifier: "payment_id") as! PaymentViewController
//        navigationController?.pushViewController(paymentMethod, animated: true)
        UIApplication.shared.open(URL(string: "https://bdalimentos.org/make-a-donation/?cause_id=8492")! as URL, options: [:], completionHandler: nil)
        }
    @IBAction func didTapButtonColor(sender: UIButton){
        resetColor()
        sender.backgroundColor = .red
        sender.setTitleColor(.white, for: .normal)
        
    }
    
    @IBAction func didTapButtonColorEquivalent(sender: UIButton){
        resetColorEquivalent()
        sender.backgroundColor = .systemYellow
        sender.setTitleColor(.white, for: .normal)
        
    }
    
    

}
