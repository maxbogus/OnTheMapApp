//
//  ParseConstants.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 29/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

// MARK: - ParseClient (Constants)

extension ParseClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: API Key
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let AppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "api.themoviedb.org"
        static let ApiPath = "/parse/classes"
        static let StudentLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation/"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Account
        static let StudentLocation = "/StudentLocation"        
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "id"
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
        static let MediaType = "media_type"
        static let MediaID = "media_id"
        static let Favorite = "favorite"
        static let Watchlist = "watchlist"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        
        // MARK: Account
        static let UserID = "id"
        
        // MARK: Config
        static let ConfigBaseImageURL = "base_url"
        static let ConfigSecureBaseImageURL = "secure_base_url"
        static let ConfigImages = "images"
        static let ConfigPosterSizes = "poster_sizes"
        static let ConfigProfileSizes = "profile_sizes"
        
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
        
        // MARK: Movies
        static let MovieID = "id"
        static let MovieTitle = "title"
        static let MoviePosterPath = "poster_path"
        static let MovieReleaseDate = "release_date"
        static let MovieReleaseYear = "release_year"
        static let MovieResults = "results"
        
    }
    
    // MARK: Poster Sizes
    struct PosterSizes {
        static let RowPoster = ParseClient.sharedInstance().config.posterSizes[2]
        static let DetailPoster = ParseClient.sharedInstance().config.posterSizes[4]
    }
}
