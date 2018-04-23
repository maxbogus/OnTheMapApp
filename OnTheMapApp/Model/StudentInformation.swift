//
//  StudentInformation.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//
class StudentsInformationDataSourse {
    var locations = [StudentInformation]()
    var currentStudentLocation: StudentInformation?
    
    // MARK: Shared Instance
    class func sharedInstance() -> StudentsInformationDataSourse {
        struct Singleton {
            static var sharedInstance = StudentsInformationDataSourse()
        }
        return Singleton.sharedInstance
    }
}

struct StudentInformation {
    
    // MARK: Properties

    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaUrl: String?
    let objectId: String?
    let uniqueKey: String?
    let updatedAt: String?
    
    // MARK: Initializers
    
    // construct a StudentInformation from a dictionary
    init(dictionary: [String:AnyObject]) {
        createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as? String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        mediaUrl = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as? String
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
    return lhs.uniqueKey == rhs.uniqueKey
}
