//
//  CompleteNewPlaceViewController.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 10/04/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit
import MapKit

class CompleteNewPlaceViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    var location: CLLocation!
    var url: String = ""
    var userData: [String: AnyObject] = [:]
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func returnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishAdd(_ sender: Any) {
        finishButton.loadingIndicator(true)
        var studentLocation: StudentInformation?
        UdacityClient.sharedInstance().getPublicUserData() { (userData, error) in
            if let data = userData {
                self.userData = data as! [String : AnyObject]
            } else {
                print("Error. Cannot get userData: \(String(describing: userData))")
            }
        }
        
        print(self.userData as Any)
        
        ParseClient.sharedInstance().getStudentLocation() { (location, error) in
            if let location = location {
                studentLocation = location.first
            } else {
                print("Error. Cannot get studentLocation: \(String(describing: location))")
            }
        }
        
        print(studentLocation as Any)
        
        // get location for user data
        // get user data

        if (studentLocation != nil) {
            ParseClient.sharedInstance().updateStudentLocation(studentLocation!) { (result, error) in
                if result != nil {
                    self.finishButton.loadingIndicator(false)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            ParseClient.sharedInstance().createStudentLocation(studentLocation!) { (result, error) in
                if let result = result {
                    self.finishButton.loadingIndicator(false)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        // get user data
        // store it to vars
        super.viewDidLoad()
        self.addPin()
    }
    
    func addPin() {
        let pointAnnotation = MKPointAnnotation()
        let coordinates = self.location.coordinate
        let region = MKCoordinateRegionMake(coordinates, MKCoordinateSpanMake(0.01, 0.01))
        // get first and second from user data
        let first = "Max"
        let last = "Bogus"
        pointAnnotation.title = "\(first) \(last)"
        pointAnnotation.subtitle = url
        pointAnnotation.coordinate = coordinates
        map.addAnnotation(pointAnnotation)
        map.setRegion(region, animated: true)
    }
}
