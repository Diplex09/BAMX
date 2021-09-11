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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var greetLbl: UILabel!
    
    let eventList = "cellToEventCard"
    let reuseIdentifier = "eventCell"
    let reference = Database.database().reference(withPath: "events")
    var referenceObservers: [DatabaseHandle] = []
    
    let usersReference = Database.database().reference(withPath: "online") //logged in users
    
    let storage = Storage.storage()
    // Properties
    var events: [Event] = []
    let dummyEvents = [
                Event(id: 1, title: "Event1", description: "desc", date: Date(), place: Place(latitude: 0, longitude: 0), img:  #imageLiteral(resourceName: "eventPlaceholder")),
                Event(id: 2, title: "Event2", description: "desc", date: Date(), place: Place(latitude: 0, longitude: 0), img: #imageLiteral(resourceName: "event_2"))]
    var user: User?
    var onlineUserCount =  UIBarButtonItem()
    var handle: AuthStateDidChangeListenerHandle?
    var listenerHandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        handle = Auth.auth().addStateDidChangeListener({ (_, user) in
            if user == nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
        
        /*let completed = reference.observe(.value) { snapshot in
            var newEvents: [Event] = []
            
            for counter in 1...snapshot.childrenCount {
                let ev = self.reference.child("event\(counter)")
                    ev.observe(.value) { snapshot in
                        if
                            let event = Event(snapshot: snapshot) {
                                print("ADDING ITEM")
                                newEvents.append(event)
                                //print(newEvents) //aqui si imprime
                                self.events = newEvents
                            print(self.events)
                        }
                        else {
                            print("No event \(counter)")
                        }
                    }
            }
            //self.events = newEvents
            print(self.events)
            self.collectionView.reloadData()
        }
        
        print("My events: ",self.events) //nada
        referenceObservers.append(completed)*/
            
            
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        referenceObservers.forEach(reference.removeObserver(withHandle:))
        referenceObservers = []
        
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

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return events.count
        return dummyEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventCollectionViewCell
           
        // Configure the cell
        let event = dummyEvents[indexPath.item]
               
        /*let storageRef = storage.reference()
        let ref = storageRef.child("event_\(indexPath.row)")
               
        cell.configure(with: event, imageRef: ref)*/
        cell.event = event
        cell.layoutIfNeeded()
        
        return cell
    }
}
