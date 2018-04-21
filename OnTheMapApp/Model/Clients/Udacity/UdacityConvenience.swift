//
//  UdacityConvenience.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit
import Foundation

// MARK: - TMDBClient (Convenient Resource Methods)

extension UdacityClient {
    
    // MARK: Authentication (GET) Methods
    /*
     Method: https://www.udacity.com/api/session
     Method Type: POST
     Required Parameters:
     udacity - (Dictionary) a dictionary containing a username/password pair used for authentication
     username - (String) the username (email) for a Udacity student
     password - (String) the password for a Udacity student
     */
    func authenticateWithViewController(_ hostViewController: UIViewController, _ params: [String: AnyObject], completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {

        // get session ID with login and password
        self.getSessionID(params) { (success, sessionID, userID, errorString) in
            if success {
                // success! we have the sessionID!
                self.sessionID = sessionID
                self.userID = userID
                completionHandlerForAuth(success, errorString)
            } else {
                completionHandlerForAuth(success, errorString)
            }
        }
    }
    
    func logoutWithViewController(_ hostViewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        // get session ID with login and password
        self.deleteSessionID() { (success, sessionID, errorString) in
            if success {
                // success! we have the sessionID!
                self.sessionID = sessionID
                completionHandlerForAuth(success, errorString)
            } else {
                completionHandlerForAuth(success, errorString)
            }
        }
    }
    
    private func getSessionID(_ params: [String: AnyObject], completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ userID: Int?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let jsonBody = "{\"\(JSONBodyKeys.Udacity)\": {\"\(JSONBodyKeys.Username)\": \"\(params["email"] ?? "email" as AnyObject)\", \"\(JSONBodyKeys.Password)\": \"\(params["password"] ?? "password" as AnyObject)\"}}"
        /* 2. Make the request */
        let _ = taskForPOSTMethod(Methods.AuthenticationSession, parameters: nil, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForSession(false, nil, nil, "Login Failed.")
            } else {
                if let session = results?[UdacityClient.JSONResponseKeys.Session] as? NSDictionary, let accout = results?[UdacityClient.JSONResponseKeys.Account] as? NSDictionary {
                    if let sessionID = session[UdacityClient.JSONResponseKeys.SessionID] as? String, let userID = session[UdacityClient.JSONResponseKeys.RegisteredKey] as? Int {
                        completionHandlerForSession(true, sessionID, userID, nil)
                    } else {
                        print("Could not find \(UdacityClient.JSONResponseKeys.SessionID) in \(results!)")
                        completionHandlerForSession(false, nil, nil, "Login Failed (SessionID).")
                    }
                } else {
                    print("Could not find \(UdacityClient.JSONResponseKeys.Session) in \(results!)")
                    completionHandlerForSession(false, nil, nil, "Login Failed (Session).")
                }
            }
        }
    }
    
    // MARK: GET Convenience Methods
    
    func getPublicUserData(_ completionHandlerForGetPublicUserData: @escaping (_ result: NSDictionary?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [UdacityClient.ParameterKeys.SessionID: UdacityClient.sharedInstance().sessionID!]
        var mutableMethod: String = Methods.GetUsers
//        mutableMethod = substituteKeyInMethod(mutableMethod, key: UdacityClient.URLKeys.UserID, value: String(UdacityClient.sharedInstance().userID!))!
        
        /* 2. Make the request */
        let _ = taskForGETMethod(mutableMethod, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForGetPublicUserData(nil, error)
            } else {
                
                if let results = results?[UdacityClient.JSONResponseKeys.UserResults] as? [[String:AnyObject]] {
                    
                    let userData = ["result": "true"]
                    completionHandlerForGetPublicUserData(userData as NSDictionary, nil)
                } else {
                    completionHandlerForGetPublicUserData(nil, NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getPublicUserData"]))
                }
            }
        }
    }
    
    // MARK: Delete Convenience Methods
    
    func deleteSessionID(completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        /* 2. Make the request */
        let _ = taskForDELETEMethod(Methods.AuthenticationSession) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if error != nil {
                completionHandlerForSession(false, nil, "delete session failed")
            } else {
                if let session = results?[UdacityClient.JSONResponseKeys.Session] as? NSDictionary {
                    if (session[UdacityClient.JSONResponseKeys.SessionID] as? String) != nil {
                        completionHandlerForSession(true, nil, nil)
                    } else {
                        print("Could not find \(UdacityClient.JSONResponseKeys.SessionID) in \(results!)")
                        completionHandlerForSession(false, nil, "Login Failed (SessionID).")
                    }
                } else {
                    completionHandlerForSession(false, nil, "logout failed")
                }
            }
        }
    }
}
