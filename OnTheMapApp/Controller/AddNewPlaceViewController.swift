//
//  AddNewPlaceViewController.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 30/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit
import CoreLocation

class AddNewPlaceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var labelTextField: UILabel!
    @IBOutlet weak var addLocationButton: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        locationTextField.text = ""
        linkTextField.text = ""
        labelTextField.text = ""
        dismiss(animated: true, completion: nil)
    }
    
    lazy var geocoder = CLGeocoder()
    
    @IBAction func addLocation(_ sender: Any) {
        
        if let location = locationTextField.text, let link = linkTextField.text {
            ParseClient.sharedInstance().url = link
            // Geocode Address String
            geocoder.geocodeAddressString(location) { (placemarks, error) in
                // Process Response
                self.processResponse(withPlacemarks: placemarks, error: error)
            }
            
            // Update View
            addLocationButton.isHidden = true

        } else {
            labelTextField.text = "location or link doesn't added"
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        linkTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        addLocationButton.isHidden = false
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            labelTextField.text = "Unable to Find Location for Address"
            
        } else {
            var location: CLLocation! = nil
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                if (CLLocationCoordinate2DIsValid(location.coordinate)) {
                    ParseClient.sharedInstance().coordinate = location
                    let controller = storyboard!.instantiateViewController(withIdentifier: "CompleteNewPlaceViewControllerUI")
                    present(controller, animated: true, completion: nil)
                }                
            } else {
                labelTextField.text  = "No Matching Location Found"
            }
        }
    }
}

