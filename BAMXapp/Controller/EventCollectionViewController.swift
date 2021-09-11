//
//  EventCollectionViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/9/21.
//

import UIKit
import Firebase
import FirebaseStorage

private let reuseIdentifier = "eventCell"

class EventCollectionViewController: UIViewController {
        
    let eventList = "cellToEventCard"
    let reference = Database.database().reference(withPath: "events")
    var referenceObservers: [DatabaseHandle] = []
        
    let usersReference = Database.database().reference(withPath: "online") //logged in users
        
    let storage = Storage.storage()
    // Properties
    var events: [Event] = []
    var user: User?
    var onlineUserCount =  UIBarButtonItem()
    var listenerHandle: AuthStateDidChangeListenerHandle?
    let reuseIdentifier = "eventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
        
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            
        let completed = reference.observe(.value) { snapshot in
            print(snapshot.childrenCount)
            var newEvents: [Event] = []
            
            for counter in 1...snapshot.childrenCount {
                let ev = self.reference.child("event\(counter)")
                    ev.observe(.value) { snapshot in
                        if
                            let event = Event(snapshot: snapshot) {
                                print("ADDING ITEM")
                                newEvents.append(event)
                                print(newEvents) //aqui si imprime
                        }
                        else {
                            print("No event \(counter)")
                        }
                    }
            }
            self.events = newEvents
            print("My events in snap: ",self.events) // aqui nada
            self.collectionView.reloadData()
        }
            
        self.events = newEvents
        print("My events: ",self.events) //nada
        referenceObservers.append(completed)
            
            
        listenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else { return }
                
            self.user = User(authData: user)
                
            let curentUserRef = self.usersReference.child(user.uid)
            curentUserRef.setValue(user.email)
            curentUserRef.onDisconnectRemoveValue()
        }
            
        let users = usersReference.observe(.value) { snapshot in
            if snapshot.exists() {
                self.onlineUserCount.title = snapshot.childrenCount.description
            }
            else {
                    self.onlineUserCount.title = "0"
            }
        }
            
            // usersReferenceObservers.append(users) //no necesario
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        referenceObservers.forEach(reference.removeObserver(withHandle:))
        referenceObservers = []
            
        guard let handle = listenerHandle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    
    
    // MARK: Process data
    
    @IBAction func eventCellDidTouch(_ sender: AnyObject) {
        
    }
}

extension EventCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return events.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventCollectionViewCell
    
        // Configure the cell
        let event = events[indexPath.row]
        
        let storageRef = storage.reference()
        let ref = storageRef.child("event_\(indexPath.row)")
        
        cell.configure(with: event, imageRef: ref)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }*/
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
