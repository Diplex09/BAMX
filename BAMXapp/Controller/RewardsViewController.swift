//
//  RewardsViewController.swift
//  BAMXapp
//
//  Created by Alonso Garcia on 09/09/21.
//

import UIKit
import Firebase

class RewardsViewController : UIViewController {
    
    @IBOutlet weak var SpecialReward: UIImageView!
    @IBOutlet weak var rewardsCollectionView: UICollectionView!
    var rewards: [Reward] = []
    
    let reference = Database.database().reference(withPath: "rewards")
    var referenceObservers: [DatabaseHandle] = []
    
    let usersReference = Database.database().reference(withPath: "online") //logged in users
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardsCollectionView.delegate = self
        rewardsCollectionView.dataSource = self
        
        fetch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7 ) {
            print("Reload rewards...")
            
            self.SpecialReward.load(url: self.rewards[0].imgURL)
            self.rewardsCollectionView.reloadData()
        }
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    func fetch() {
        let completed = reference.observe(.value) { snapshot in
            
            for counter in 1...snapshot.childrenCount {
                let re = self.reference.child("reward_\(counter)")
                re.observe(.value) { snapshot in
                        if
                            let reward = Reward(snapshot: snapshot) {
                                print("ADDING REWARD")
                                self.rewards.append(reward)
                                print("Rewards dentro de for: ", self.rewards)
                        }
                        else {
                            print("No event \(counter)")
                        }
                    }
                }
            }
        
        referenceObservers.append(completed)
    }
}

extension RewardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewards.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rewardCell", for: indexPath) as! RewardCollectionViewCell
        
        cell.setup(rewards[indexPath.row + 1])
        return cell
    }
}
