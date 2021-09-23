//
//  MainMenuViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/8/21.
//
import UIKit
import Firebase
import iCarousel

class MainMenuViewController: UIViewController, iCarouselDelegate, iCarouselDataSource {
    
    var uid = ""
    var email = ""
    var name = ""
    
    @IBOutlet weak var eventCardsView: iCarousel!
    @IBOutlet weak var greetLbl: UILabel!
    
    let eventList = "cellToEventCard"
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
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        eventCardsView.type = .linear
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
        greetLbl.text = "Hola, " + shortName[0]
    }
    
}

extension MainMenuViewController {
    
    @objc private func didTapCard(_ sender: UITapGestureRecognizer) {
        print("did tap card", sender)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return dummyEvents.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: eventCardsView.frame.width, height: eventCardsView.frame.height))
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCard(_:)))
        tempView.addGestureRecognizer(tapGestureRecognizer)
        
        
        let event = dummyEvents[index]
        // TODO: fix sizes
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: eventCardsView.frame.width, height: eventCardsView.frame.height - 80))
        imgView.image = event.eventImage
        imgView.cornerRadius = 20
        imgView.contentMode = .scaleAspectFit
        
        let titleLbl = UILabel(frame: CGRect(x: 20, y: 70, width: eventCardsView.frame.width, height: eventCardsView.frame.height - 50))
        titleLbl.text = event.title
        titleLbl.font = UIFont(name: "Lato-Bold", size: 18)
        
        let dateLbl = UILabel(frame: CGRect(x: 20, y: 90, width: eventCardsView.frame.width, height: eventCardsView.frame.height - 30))
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "EEE, d, MMMM, y  HH:mm" //dia sem (Lun), dia, mes, año, hora::min
        //checar formato, pero creo q esta bien...
        dateLbl.text = dateFormatter.string(from: event.date)
        dateLbl.font = UIFont(name: "Lato-Regular", size: 14)
        dateLbl.textColor = .gray
        
        
        tempView.addSubview(imgView)
        tempView.addSubview(titleLbl)
        tempView.addSubview(dateLbl)
        
        tempView.cornerRadius = 20
        tempView.backgroundColor = .white
        
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if option == iCarouselOption.spacing {
            return value * 1.1
        }
        
        return value
    }
}
