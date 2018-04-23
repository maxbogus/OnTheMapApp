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
    var mapString: String = ""
    var objectId: String = ""
    var userData: [String: AnyObject] = [:]
    var httpBody: String = ""
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func returnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishAdd(_ sender: Any) {
        finishButton.loadingIndicator(true)
        self.getLocation()
    }
    
    override func viewDidLoad() {
        // get user data
        // store it to vars
        super.viewDidLoad()
        UdacityClient.sharedInstance().getPublicUserData() { (userData, error) in
            if let data = userData {
                self.userData = data
                self.addPin()
            } else {
                print("Error. Cannot get userData: \(String(describing: userData))")
            }
        }
    }
    
    func addPin() {
        let pointAnnotation = MKPointAnnotation()
        let coordinates = self.location.coordinate
        let region = MKCoordinateRegionMake(coordinates, MKCoordinateSpanMake(0.01, 0.01))
        // get first and second from user data
        let first = userData[UdacityClient.JSONResponseKeys.FirstName] as! String
        let nick = userData[UdacityClient.JSONResponseKeys.NickName] as! String
        let last = userData[UdacityClient.JSONResponseKeys.LastName] as! String
        pointAnnotation.title = "\(first) '\(nick)' \(last)"
        pointAnnotation.subtitle = url
        pointAnnotation.coordinate = coordinates
        self.saveData(coordinates: coordinates)
        map.addAnnotation(pointAnnotation)
        map.setRegion(region, animated: true)
    }
    
    func saveData(coordinates: CLLocationCoordinate2D) {
        httpBody = "{\"uniqueKey\": \"\(UdacityClient.sharedInstance().userID!)\", \"firstName\": \"\(userData[UdacityClient.JSONResponseKeys.FirstName] as! String)\", \"lastName\": \"\(userData[UdacityClient.JSONResponseKeys.LastName] as! String)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(url)\",\"latitude\": \(coordinates.latitude), \"longitude\": \(coordinates.longitude)}"
    }
    
    
    
    func getLocation() {
        ParseClient.sharedInstance().getStudentLocation() { (location, error) in
            if let location = location {
                let firstLocation = location.first
                self.objectId = (firstLocation?.objectId)!
                self.completePin()
            } else {
                DispatchQueue.main.async {
                    self.finishButton.loadingIndicator(false)
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func completePin() {        
        // get location for user data
        // get user data
        
        if (StudentsInformationDataSourse.sharedInstance().currentStudentLocation != nil) {
            print(StudentsInformationDataSourse.sharedInstance().currentStudentLocation as Any)
            ParseClient.sharedInstance().updateStudentLocation(objectId: objectId, httpBody: httpBody) { (result, error) in
                if result != nil {
                    DispatchQueue.main.async {
                        self.finishButton.loadingIndicator(false)
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.finishButton.loadingIndicator(false)
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            ParseClient.sharedInstance().createStudentLocation(httpBody: httpBody) { (result, error) in
                if result != nil {
                    DispatchQueue.main.async {
                        self.finishButton.loadingIndicator(false)
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.finishButton.loadingIndicator(false)
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
