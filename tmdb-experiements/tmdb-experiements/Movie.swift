//
//  Movie.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation

struct Movie {
    
    let title: String
    let year: String
    let rating: String
    let runTime: String
    let userRating: String
    let synopsis: String
    let genre: String
    let director: String
    let cast: [String]
    
//    init?(jsonDictionary: [String: Any]) {
//        guard let title = jsonDictionary["title"] as? String,
//              let year = jsonDictionary["year"] as? String,
//            let rating = jsonDictionary["rating"] as? String
//            
//            else {
//                return nil
//        }
//        self.title = title
//        self.year = year
//        self.rating = rating
//    }
}
