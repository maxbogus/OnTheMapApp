//
//  OnTheMapTabViewController.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 09/04/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit

class OnTheMapTabViewController: UITabBarController {
    
    @IBAction func refresh(_ sender: Any) {
        ParseClient.sharedInstance().getStudentLocations() { (students, error) in
            if let students = students {
                StudentsInformationDataSourse.sharedInstance().locations = students
            } else {
                let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addMarker(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddNewPlaceViewControllerUI")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UdacityClient.sharedInstance().logoutWithViewController(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogout()
                } else {
                    // create the alert
                    let alert = UIAlertController(title: "Logout error", message: "\(String(describing: errorString))", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func completeLogout() {
        dismiss(animated: true, completion: nil)
    }
}
