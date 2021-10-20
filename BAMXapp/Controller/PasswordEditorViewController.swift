//
//  PasswordEditorViewController.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 19/10/21.
//

import UIKit
import Firebase

class PasswordEditorViewController: UIViewController {
    @IBOutlet var currentUser: UILabel!
    var profileRecords = ProfileRecord.fetchProfileRecords()
    var uid = ""
    var email = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()

        // Do any additional setup after loading the view.
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
