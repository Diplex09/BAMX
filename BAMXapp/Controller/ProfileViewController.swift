//
//  ProfileViewController.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 08/09/21.
//

import UIKit
import Firebase


class ProfileViewController : UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var currentUser: UILabel!
    
    var profileRecords = ProfileRecord.fetchProfileRecords()
    var uid = ""
    var email = ""
    var name = ""



    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        
        collectionView.dataSource = self

    }
    
    @IBAction func didTapChangePassword(){
        let vc = storyboard?.instantiateViewController(identifier: "password_editor_vc") as! PasswordEditorViewController
        present(vc, animated: true)
    }
    
    @IBAction func didTapChangeProfile(){
        let cvc = storyboard?.instantiateViewController(identifier: "profile_changer_vc") as! ProfileChangerViewController
        present(cvc, animated: true)
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

extension ProfileViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileRecords.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let profileRecord = profileRecords[indexPath.item]
        
        cell.profileRecord = profileRecord
        return cell
    }
}
  
