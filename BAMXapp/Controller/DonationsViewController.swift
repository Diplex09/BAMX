//
//  DonationsViewController.swift
//  BAMXapp
//
//  Created by Mar Mendoza on 06/09/21.
//

// ViewControllerDonation

import UIKit

func returnBtnValue(btnTitle: String) ->(String){
    let btnChoose = btnTitle
    return(btnChoose)
}


class CellClass: UITableViewCell{
    
}

class DonationsViewController: UIViewController {
    
    @IBOutlet var btnDonationType: UIButton!
    @IBOutlet weak var btnDonatorType: UIButton!
    @IBOutlet var btnEventType: UIButton!
     

    let transparentView = UIView()
    let tableView = UITableView()
    var currentBtn = UIButton()
    var dataSource = [String]()
    var viewChoose: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        hideNavigationController()
        
        // Do any additional setup after loading the view.
    }
    
    
    func hideNavigationController(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5,width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        viewChoose = btnDonationType.currentTitle!
        let frames = currentBtn.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y +
            frames.height,width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    
    @IBAction func onClickDonation(_ sender: UIButton) {
        //let labelText = sender.currentTitle!
        dataSource = ["Efectivo", "Despensa"]
        currentBtn = btnDonationType
        addTransparentView(frames: btnDonationType.frame)
    }
    
    @IBAction func onClickDonator(_ sender: Any) {
        dataSource = ["Normal", "Recurrente"]
        currentBtn = btnDonatorType
        addTransparentView(frames: btnDonatorType.frame)
    }
    
    
    @IBAction func onClickEvent(_ sender: Any) {
        dataSource = ["Comer en Familia", "Donación a casa hogar"]
        currentBtn = btnEventType
        addTransparentView(frames: btnDonatorType.frame)
    }
    
    
    @IBAction func didTapButton(){
        let moneyChoice = storyboard?.instantiateViewController(identifier: "money_donation") as! MoneyChoiceViewController
        if viewChoose == "Efectivo" {
            //present(moneyChoice, animated: true)
            navigationController?.pushViewController(moneyChoice, animated: true)
        }
    }
}

extension DonationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentBtn.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
