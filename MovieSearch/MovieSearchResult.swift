//
//  MovieSearchResult.swift
//  MovieSearch
//
//  Created by Roman Rozhok on 9/10/16.
//  Copyright © 2016 Roman Rozhok. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieSearchResult: Mappable {
    var totalResults: Int!
    var response: Bool!
    var movies: [Movie]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        totalResults    <- map["totalResults"]
        response         <- map["Response"]
        movies      <- map["Search"]
    }
}
