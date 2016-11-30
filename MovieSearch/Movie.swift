//
//  Movie.swift
//  MovieSearch
//
//  Created by Roman Rozhok on 9/9/16.
//  Copyright © 2016 Roman Rozhok. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
    
    // Movie Search returns this data:
    var imdbID: String!
    var posterUrl: String!
    var title: String!
    var year: String!
    
    // Movie Details returns more data:
    var rated: String!
    var released: String!
    var runtime: String!
    var genre: String!
    var director: String!
    var writer: String!
    var actors: String!
    var plot: String!
    var language: String!
    var country: String!
    var awards: String!
    var metascore: String!
    var imdbRating: String!
    var imdbVotes: String!
    var response: String!
    
    init(posterUrl: String, title: String, year: String){
        self.posterUrl = posterUrl
        self.title = title
        self.year = year
    }
    
    
    // init (required for ObjectMapper)
    required init?(map: Map) {
        
    }
    
    // Mappable (required for ObjectMapper)
    func mapping(map: Map) {
        imdbID    <- map["imdbID"]
        posterUrl    <- map["Poster"]
        title         <- map["Title"]
        year      <- map["Year"]
        rated      <- map["Rated"]
        released      <- map["Released"]
        runtime      <- map["Runtime"]
        genre      <- map["Genre"]
        director      <- map["Director"]
        writer      <- map["Writer"]
        actors      <- map["Actors"]
        plot      <- map["Plot"]
        language      <- map["Language"]
        country      <- map["Country"]
        awards      <- map["Awards"]
        metascore      <- map["Metascore"]
        imdbRating      <- map["imdbRating"]
        imdbVotes      <- map["imdbVotes"]
        response      <- map["Response"]
    }
}
