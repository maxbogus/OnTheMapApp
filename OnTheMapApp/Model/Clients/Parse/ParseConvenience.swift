//
//  ParseConvenience.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//
//
//  UdacityConvenience.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit
import Foundation

// MARK: - ParseClient (Convenient Resource Methods)

extension ParseClient {
   
    // MARK: GET Convenience Methods
    
    func getStudentLocations(_ completionHandlerForStudentLocations: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [ParameterKeys.Limit: ParameterValues.LimitValue,
                          ParameterKeys.Order: ParameterValues.OrderType]
        /* 2. Make the request */
        let _ = taskForGETMethod(Methods.StudentLocation, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudentLocations(nil, error)
            } else {
                if let results = results?[ParseClient.JSONResponseKeys.StudentsResults] as? [[String:AnyObject]] {
                    
                    let students = StudentInformation.studentsFromResults(results)
                    completionHandlerForStudentLocations(students, nil)
                } else {
                    completionHandlerForStudentLocations(nil, NSError(domain: "getFavoriteMovies parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getFavoriteMovies"]))
                }
            }
        }
    }

    func getStudentLocation(_ completionHandlerForStudentLocation: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {

        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let key = "\(UdacityClient.sharedInstance().userID!)"
        let parameters = [ParameterKeys.Where: "%7B%22uniqueKey%22%3A%\(key)%22%7D"]

        /* 2. Make the request */
        let _ = taskForGETMethod(Methods.StudentLocation, parameters: parameters as [String:AnyObject]) { (results, error) in

            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudentLocation(nil, error)
            } else {

                if let results = results?[ParseClient.JSONResponseKeys.StudentsResults] as? [[String:AnyObject]] {
                    print(results)

                    let students = StudentInformation.studentsFromResults(results)
                    completionHandlerForStudentLocation(students, nil)
                } else {
                    completionHandlerForStudentLocation(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
                }
            }
        }
    }

    // MARK: POST Convenience Methods
    func createStudentLocation(completionHandlerForcreateStudentLocation: @escaping (_ result: Bool?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [ParameterKeys.Limit: ParameterValues.LimitValue,
                          ParameterKeys.Order: ParameterValues.OrderType]
        let httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"
        
        /* 2. Make the request */
        let _ = taskForPOSTMethod(Methods.StudentLocation, parameters: parameters as [String : AnyObject], httpBody: httpBody as String) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForcreateStudentLocation(nil, error)
            } else {
                if let results = results?[ParseClient.JSONResponseKeys.StatusCode] as? Bool {
                    completionHandlerForcreateStudentLocation(results, nil)
                } else {
                    completionHandlerForcreateStudentLocation(nil, NSError(domain: "createStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse createStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: PUT Convenience Methods
    func updateStudentLocation(completionHandlerForUpdateStudentLocation: @escaping (_ result: Bool?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [ParameterKeys.Limit: ParameterValues.LimitValue,
                          ParameterKeys.Order: ParameterValues.OrderType]
        let httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"

        /* 2. Make the request */
        let _ = taskForPUTMethod(Methods.StudentLocation, parameters: parameters as [String : AnyObject], httpBody: httpBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForUpdateStudentLocation(nil, error)
            } else {
                if let results = results?[ParseClient.JSONResponseKeys.StatusCode] as? Bool {
                    completionHandlerForUpdateStudentLocation(results, nil)
                } else {
                    completionHandlerForUpdateStudentLocation(nil, NSError(domain: "updateStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse updateStudentLocation"]))
                }
            }
        }
    }
}

