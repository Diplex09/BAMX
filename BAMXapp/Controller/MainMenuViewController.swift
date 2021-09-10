//
//  MainMenuViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/8/21.
//
import UIKit
import Firebase

class MainMenuViewController: UIViewController {
    
    var uid = ""
    var email = ""
    var name = ""
    
    @IBOutlet weak var greetLbl: UILabel!
    
    let eventList = "cellToEventCard"
    let reference = Database.database().reference()
    var referenceObservers: [DatabaseHandle] = []
    
    let usersReference = Database.database().reference(withPath: "online") //logged in users
    
    let storage = Storage.storage()
    // Properties
    var events: [Event] = []
    var user: User?
    var onlineUserCount =  UIBarButtonItem()
    var handle: AuthStateDidChangeListenerHandle?
    let reuseIdentifier = "eventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        handle = Auth.auth().addStateDidChangeListener({ (_, user) in
            if user == nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let handle = handle else { return }
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func getUserProfile(){
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
        greetLbl.text = "Hola " + shortName[0]
    }
}
