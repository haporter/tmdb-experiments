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
private let kRuntime = "runtime"
private let kGenre = "genres"
private let kCredits = "credits"
private let kDirector = "director"
private let kCrew = "crew"
private let kJob = "job"
private let kCast = "cast"
private let kName = "name"

class Movie: Equatable {
    
    let id: Int
    let title: String
    let year: String
    var runtime: Int?
    let userRating: Double
    let synopsis: String
    var genres: [String] = []
    var director: String?
    var cast: Set<String> = []
    private var posterPath: String
    private var backdropPath: String
    var liked = false
    var favorite = false
    
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
        self.runtime = nil
        self.director = nil
    }
    
    func loadPoster() {
        if let posterURL = MovieController.shared.configuration?.posterURLMedium()?.appendingPathComponent(posterPath),
            let posterData = try? Data(contentsOf: posterURL) {
            
            poster = UIImage(data: posterData)
        }
    }
    
    func loadBackdrop() {
        if let url = MovieController.shared.configuration?.backdropURLMedium()?.appendingPathComponent(backdropPath),
            let backdropData = try? Data(contentsOf: url) {
            
            backdrop = UIImage(data: backdropData)
        }
    }
    
    func loadOperation() -> DataLoadOperation? {
        if poster != nil {
            return .none
        }
        return DataLoadOperation(self)
    }
    
    func update(_ detailsJSON: jsonDictionary) {
        guard let runtime = detailsJSON[kRuntime] as? Int,
            let genreJSON = detailsJSON[kGenre] as? [jsonDictionary],
            let creditsJSON = detailsJSON[kCredits] as? jsonDictionary,
            let crewJSON = creditsJSON[kCrew] as? [jsonDictionary],
            let castJSON = creditsJSON[kCast] as? [jsonDictionary]
            else { return }
        
        for (value) in crewJSON {
            let job = value[kJob] as? String
            if job == "Director" {
                self.director = value[kName] as? String
            }
        }
        
        self.genres = genreJSON.flatMap({ $0[kName] as? String })
        self.runtime = runtime
        
        var cast = [String]()
        for (index, value) in castJSON.enumerated() {
            if index < 5 {
                cast.append(value[kName] as! String)
            } else {
                break
            }
        }
        self.cast = Set(cast)
        print(cast)
        loadBackdrop()
    }
    
    func toggleLike() {
        self.liked = !self.liked
    }
    
    func toggleFavorite() {
        self.favorite = !self.favorite
    }
}

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}



























