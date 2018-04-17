//
//  LoginViewController.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 22/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func loginAction(_ sender: Any) {
        let params = ["email": emailTextField.text,
                      "password": passwordTextField.text
        ]
        UdacityClient.sharedInstance().authenticateWithViewController(self, params as [String : AnyObject]) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    self.displayError(errorString)
                }
            }
        }
    }
    
    @IBAction func signUpFunction(_ sender: Any) {
        let udacityUrl = NSURL(string: "https://www.udacity.com/account/auth#!/signup")! as URL
        UIApplication.shared.open(udacityUrl, options: [:], completionHandler: nil)
    }
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            messageLabel.text = errorString
        }
    }
    
    private func completeLogin() {
        messageLabel.text = ""
        let controller = storyboard!.instantiateViewController(withIdentifier: "NavigationViewController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
