//
//  StudentInformation.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

struct StudentInformation {
    
    // MARK: Properties
    
    let title: String
    let id: Int
    // "createdAt": "2015-02-25T01:10:38.103Z",
    //"firstName": "Jarrod",
    //"lastName": "Parkes",
    //"latitude": 34.7303688,
    //"longitude": -86.5861037,
    //"mapString": "Huntsville, Alabama ",
    //"mediaURL": "https://www.linkedin.com/in/jarrodparkes",
    //"objectId": "JhOtcRkxsh",
    //"uniqueKey": "996618664",
    //"updatedAt": "2015-03-09T22:04:50.315Z"
    
    // MARK: Initializers
    
    // construct a StudentInformation from a dictionary
    init(dictionary: [String:AnyObject]) {
        title = dictionary[ParseClient.JSONResponseKeys.MovieTitle] as! String
        id = dictionary[ParseClient.JSONResponseKeys.MovieID] as! Int
    }
    
    static func studentsFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var students = [StudentInformation]()
        
        // iterate through array of dictionaries, each StudentInformation is a dictionary
        for result in results {
            students.append(StudentInformation(dictionary: result))
        }
        
        return students
    }
}

// MARK: - StudentInformation: Equatable

extension StudentInformation: Equatable {}

func ==(lhs: StudentInformation, rhs: StudentInformation) -> Bool {
    return lhs.id == rhs.id
}
