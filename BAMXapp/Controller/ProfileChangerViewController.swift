//
//  ProfileChangerViewController.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 19/10/21.
//

import UIKit
import Firebase

class ProfileChangerViewController: UIViewController {
    @IBOutlet var currentUser: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    
    var profileRecords = ProfileRecord.fetchProfileRecords()
    var uid = ""
    var email = ""
    var name = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeName_tapped(_ sender: Any) {
        // Register user
        guard
            let nameE = nameInput.text,
            let lastName = lastNameInput.text,
            !nameE.isEmpty,
            !lastName.isEmpty
        else {
            return
        }
        
        let fullName = String(nameE + " " + lastName)
        
        // Sign up code
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = fullName
            changeRequest.commitChanges { error in
                if error != nil {
                    guard let msg = error?.localizedDescription else { return }
                    print("No se pudo registrar con nombre: " + msg)
    
                }
                else {
                    print("Registro exitoso.")
                    
                }
                
            }
            
        }
    }
    
    func getUserProfile() {
            let user = Auth.auth().currentUser
            if user != nil {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
                uid = user?.uid ?? " "
                email = user?.email ?? " "
                name = user?.displayName ?? " "
            }
            
            let delimiter = " "
            let shortName = name.components(separatedBy: delimiter)
            print(shortName[0])
        currentUser.text = shortName[0]
        }
    



}
