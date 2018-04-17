//
//  AddNewPlaceViewController.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 30/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit

class AddNewPlaceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var labelTextField: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        locationTextField.text = ""
        linkTextField.text = ""
        labelTextField.text = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "CompleteNewPlaceViewControllerUI") 
        present(controller, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        linkTextField.delegate = self
    }
}

