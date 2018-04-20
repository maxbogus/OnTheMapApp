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
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func returnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishAdd(_ sender: Any) {
        finishButton.loadingIndicator(true)
        // get location for user data
        let exist = true
        
        
        // if exist
        if (exist) {
            // - update location
        } else {
            // - create location
        }
        finishButton.loadingIndicator(false)
        dismiss(animated: true, completion: nil)
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
