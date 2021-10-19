//
//  LoginViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/4/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController
{
    let loginToMainMenu = "loginToMainMenu"
    
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    @IBOutlet weak var createUser: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterEmail.delegate = self
        enterPassword.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        
        // Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
        // Step 2: Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Hey I'm a notification!"
        content.body = "Look at me!"
        
        // Step 3: Create the notification trigger
        let date = Date().addingTimeInterval(60)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Step 4: Create the request
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        handle = Auth.auth().addStateDidChangeListener{ _, user in
            if user == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }
            else
            {
                //self.performSegue(withIdentifier: self.loginToMainMenu, sender: nil)
                self.enterEmail.text = nil
                self.enterPassword.text = nil
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let handle = handle else{return }
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    //Move to Sign Up
    @IBAction func createUserDidTouch(_ sender: Any) {
        let signupView = (storyboard?.instantiateViewController(identifier: "signup"))!
        present(signupView, animated: true, completion: nil)
    }
    
    //Login
    @IBAction func loginDidTouch(_ sender:
    AnyObject) {
        //Require email & password
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else {
            return
        }
        
        //Start login code
        Auth.auth().signIn(withEmail: email, password: password){ user, error in
            if (error != nil) || (user == nil) {
                
                let alert = UIAlertController(
                    title: "Error al iniciar sesión :(",
                    message:  "Ingresa tus datos de nuevo", // error?.localizedDescription,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let u = Auth.auth().currentUser
                let em = u?.email ?? " "
                let name = u?.displayName ?? " "
                print("Ha ingresado: " + name + " email: " + em)
                let vc = self.navigationController?.storyboard?.instantiateViewController(withIdentifier:  "NavTabBarVC") as? CustomTabBarViewController
                vc!.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == enterEmail
        {
            enterPassword.becomeFirstResponder()
        }
        
        if textField == enterPassword
        {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
