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
    
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var greetLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
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
        var delimiter = " "
        var shortName = name.components(separatedBy: delimiter)
        greetLbl.text = "Hola " + shortName[0]
    }
}

/*extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}*/
