//
//  Movie.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

typealias jsonDictionary = [String: Any]

private let kID = "id"
private let kTitle = "title"
private let kOverview = "overview"
private let kReleaseDate = "release_date"
private let kPosterPath = "poster_path"
private let kBackDropPath = "backdrop_path"
private let kRating = "vote_average"

struct Movie: Equatable {
    
    let id: Int
    let title: String
    let year: String
    let runTime: String?
    let userRating: Double
    let synopsis: String
    let genre: String?
    let director: String?
    let cast: [String]?
    private var posterPath: String
    private var backdropPath: String
    
    var poster: UIImage?
    var backdrop: UIImage?
    
    init?(jsonDict: jsonDictionary) {
        guard let id = jsonDict[kID] as? Int,
            let title = jsonDict[kTitle] as? String,
            let year = jsonDict[kReleaseDate] as? String,
            let userRating = jsonDict[kRating] as? Double,
            let synopsis = jsonDict[kOverview] as? String,
            let posterPath = jsonDict[kPosterPath] as? String,
            let bannerPath = jsonDict[kBackDropPath] as? String
            
            else { return nil }
        
        self.id = id
        self.title = title
        self.year = String(year.characters.prefix(4))
        self.userRating = userRating
        self.synopsis = synopsis
        self.posterPath = posterPath
        self.backdropPath = bannerPath
        self.runTime = nil
        self.genre = nil
        self.director = nil
        self.cast = nil
        
        if let posterURL = MovieController.shared.configuration?.posterURLMedium()?.appendingPathComponent(posterPath),
            let posterData = try? Data(contentsOf: posterURL) {
            
            poster = UIImage(data: posterData)
        }
        
        if let url = MovieController.shared.configuration?.backdropURLMedium()?.appendingPathComponent(backdropPath),
            let backdropData = try? Data(contentsOf: url) {
            
            backdrop = UIImage(data: backdropData)
        }
    }
}

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}

