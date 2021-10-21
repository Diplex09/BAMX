//
//  SignUpViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/7/21.
//

import UIKit
import Firebase
import FBSDKLoginKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var enterLastName: UITextField!
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet var facebookBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    @IBAction func didTouchFacebookBtn(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permission: [.], from: self){ (Result)
            
        }
        
        
    }
    //Sign up
    @IBAction func signUpDidTouch(_ sender:
    AnyObject) {
        // Register user
        guard
            let name = enterName.text,
            let lastName = enterLastName.text,
            let email = enterEmail.text,
            let password = enterPassword.text,
            let confirm = confirmPassword.text,
            !name.isEmpty,
            !lastName.isEmpty,
            !email.isEmpty,
            !password.isEmpty,
            !confirm.isEmpty,
            password == confirm
        else {
            return
        }
        
        let fullName = String(name + " " + lastName)
        
        // Sign up code
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                // Add display Name
                
                let user = Auth.auth().currentUser
                   if let user = user {
                    let changeRequest = user.createProfileChangeRequest()

                      changeRequest.displayName = fullName
                    
                    changeRequest.commitChanges { error in
                        if error != nil {
                            guard let msg = error?.localizedDescription else { return }
                            print("No se pudo registrar con nombre: " + msg)
                        }
                        else {
                          print("Registro exitoso.")
                        }
                      }
                    }
                
                Auth.auth().signIn(withEmail: email, password: password)
            }
            else
            {
                print("Error creating user: \(String(describing: error?.localizedDescription))")
            }
        }
        
        
        
        
    }
    
    
    
}
