//
//  Movie.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation

struct Movie: Equatable {
    
    let id: String
    let title: String
    let year: String
    let runTime: String?
    let userRating: Double
    let synopsis: String
    let genre: String?
    let director: String?
    let cast: [String]?
    let posterPath: String
    let bannerPath: String
    
    typealias jsonDictionary = [String: Any]
    
    init?(jsonDict: jsonDictionary) {
        guard let id = jsonDict["id"] as? String,
            let title = jsonDict["title"] as? String,
            let year = jsonDict["release_date"] as? String,
            let userRating = jsonDict["vote_average"] as? Double,
            let synopsis = jsonDict["overview"] as? String,
            let posterPath = jsonDict["poster_path"] as? String,
            let bannerPath = jsonDict["backdrop_path"] as? String
            
            else { return nil }
        
        self.id = id
        self.title = title
        self.year = String(year.characters.prefix(4))
        self.userRating = userRating
        self.synopsis = synopsis
        self.posterPath = posterPath
        self.bannerPath = bannerPath
        self.runTime = nil
        self.genre = nil
        self.director = nil
        self.cast = nil
    }
}

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}

