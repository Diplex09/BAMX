//
//  ScheduleViewController.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 20/10/21.
//

import UIKit
import Firebase

class ScheduleViewController: UIViewController {

    @IBOutlet weak var dateTimePickerField: UITextField!
    
    @IBOutlet weak var placePickerField: UITextField!
    
    let places = ["Banco de Alimentos Guadalajara", "Tecnológico de Monterrey - Guadalajara Campus"]
    var placePicker = UIPickerView()
    
    let reference = Database.database().reference(withPath: "pickups")
    var referenceObservers: [DatabaseHandle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placePicker.delegate = self
        placePicker.dataSource = self

        addButtonsToPicker()
        
        let dateTimePicker = UIDatePicker()
        dateTimePicker.datePickerMode = .dateAndTime
        dateTimePicker.minuteInterval = 30
        dateTimePicker.addTarget(self, action: #selector(handleDateTimePicker), for: UIControl.Event.valueChanged)
        dateTimePickerField.inputView = dateTimePicker
    }
    
    func addButtonsToPicker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "bamx-red")
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        placePickerField.inputView = placePicker
        placePickerField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        placePickerField.resignFirstResponder()
    }
    
    @objc func handleDateTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY hh:mm a"
        dateTimePickerField.text = "\(dateFormatter.string(from: sender.date))"
    }
    
    @IBAction func save(_ sender: Any) {
        var count = 0
        
        let completed = reference.observe(.value) { snapshot in
            count = Int(snapshot.childrenCount)
        }
        
        referenceObservers.append(completed)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7 ) {
            let id = String(count + 1)
            let newPickupRef = self.reference.child("pickup_" + id)
            
            let date = self.dateTimePickerField.text
            
            let user = Auth.auth().currentUser
            var name = ""
            if user != nil {
                name = user?.displayName ?? " "
            }
            
            let location = self.placePickerField.text
            
            let pickupDict: [String: String?] = ["id": id, "date": date, "name": name, "location": location]
            
            newPickupRef.setValue(pickupDict) { (error:Error?, ref:DatabaseReference) in
              if let error = error {
                print("Data could not be saved: \(error).")
              } else {
                print("Data saved successfully!")
                
                let alert = UIAlertController(
                    title: "Recolección agendada!",
                    message: self.dateTimePickerField.text! + " en " + self.placePickerField.text!,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    (action) -> Void in
                    // if the input matches the required text
                    self.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
                
              }
            }
        }
    }
}

extension ScheduleViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return places.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placePickerField.text = places[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return places[row]
    }
}
