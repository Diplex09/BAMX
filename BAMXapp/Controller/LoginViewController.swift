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
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterEmail.delegate = self
        enterPassword.delegate = self
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
                self.performSegue(withIdentifier: self.loginToMainMenu, sender: nil)
                self.enterEmail.text = nil
                self.enterPassword.text = nil
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        <#code#>
    }
    
    @IBAction func loginDidTouch(_ sender:
    AnyObject) {
        
    }
    
    @IBAction func signUpDidTouch(_ sender:
    AnyObject) {
        
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
