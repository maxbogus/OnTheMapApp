//
//  UdacityConstants.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

// MARK: - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        static let AuthorizationURL = "https://www.udacity.com/api/session/"
    }
    
    // MARK: Methods
    struct Methods {
        static let AuthenticationSession = "/session"
        static let GetUsers = "/users"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let ApiKey = "api_key"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Query = "query"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let Account = "account"
        static let RegisteredStatus = "registered"
        static let RegisteredKey = "key"
        static let Session = "session"
        static let SessionExpiration = "expiration"
        static let SessionID = "id"
        
        // MARK: Account
        static let UserID = "id"
        
        // MARK: Get User Data
        static let UserResults = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
        static let NickName = "nickname"
    
    }
}

