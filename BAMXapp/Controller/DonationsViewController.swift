//
//  DonationsViewController.swift
//  BAMXapp
//
//  Created by Mar Mendoza on 06/09/21.
//

// ViewControllerDonation
import UIKit

class CellClass: UIViewController{
    
}

class DonationsViewController: UIViewController {
    
    @IBOutlet var btnDonationType: UIButton!
    @IBOutlet var btnDonatorType: UIButton!
    @IBOutlet var btnEvent: UIButton!
    
    let transparentview = UIView()
    let tableView = UITableView()
    
    var currentBtn = UIButton()
    var dataSource = [String()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func transparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentview.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentview)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y +
            frames.height,width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        
        transparentview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(removeTransparentView))
        
        transparentview.addGestureRecognizer(tapGesture)
        transparentview.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentview.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y +
                frames.height,width: frames.width, height: 200)
        }, completion: nil)
    }
    
    
    @objc func removeTransparentView(){
        let frames = currentBtn.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentview.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y +
            frames.height,width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
        
    }
    
    
    @IBAction func onClickDonation(_ sender: Any) {
        dataSource = ["Efectivo", "Alimentos"]
        currentBtn = btnDonationType
        transparentView(frames: btnDonationType.frame)
    }
    
    @IBAction func onClickDonator(_ sender: Any) {
    }
    
    @IBAction func onClickEvent(_ sender: Any) {
    }
    
    
}

extension DonationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentBtn.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}

