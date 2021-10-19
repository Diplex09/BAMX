//
//  ProfileViewController.swift
//  BAMXapp
//
//  Created by Diego Velázquez on 08/09/21.
//

import UIKit


class ProfileViewController : UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    var profileRecords = ProfileRecord.fetchProfileRecords()
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self

    }
    
    @IBAction func didTapChangePassword(){
        let vc = storyboard?.instantiateViewController(identifier: "password_editor_vc") as! PasswordEditorViewController
        present(vc, animated: true)
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
  
