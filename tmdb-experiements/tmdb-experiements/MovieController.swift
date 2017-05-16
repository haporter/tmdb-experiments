//
//  MovieController.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/15/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation

private let apiKey = "2f8796b287c2f5c208d03dabe8515190"

class MovieController {
    
    var movieCollections: [String: [Movie]] = [:]
    
    static let shared = MovieController()
    
    static let baseURLString = "https://api.themoviedb.org/3/movie/"
    
    enum MovieCollection {
        case nowPlaying
        case popular
        case topRated
        case id(String?)
        
        init?(value: String, id: String?) {
            switch value {
                case "now_playing": self = .nowPlaying
                case "popular": self = .popular
                case "top_rated": self = .topRated
                case "id": self = .id(id)
            default:
                return nil
            }
        }
        
        var description: String {
            switch self {
            case .nowPlaying:
                return "now_playing"
            case .popular:
                return "popular"
            case .topRated:
                return "top_rated"
            case .id(let id):
                return id!
            }
        }
    }
    
    static func getMovieData(from endpoint: MovieCollection,_ movieID: String?, completion: @escaping (_ movieIDs: [Double]?) -> Void) {
        
        var urlParameters = ["api_key": apiKey]
        var urlString = baseURLString
        
        switch endpoint {
        case .nowPlaying:
            urlString += endpoint.description
        case .popular:
            urlString += endpoint.description
        case .topRated:
            urlString += endpoint.description
        case .id:
            urlParameters["append_to_response"] = "credits,videos"
            urlString += endpoint.description
        }
        
        guard let url = URL(string: baseURLString) else {
            completion(nil)
            return
        }
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters) { (data, error) in
            
            if let error = error {
                print("Unable to get movies ids: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No movie data was returned")
                completion(nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any], let movieDicts = json["results"] as? [[String: Any]] else {
                    print("unexpected JSON format")
                    completion(nil)
                    return
                }
                
                let movieIDs = movieDicts.flatMap { $0["id"] as? Double }
                
                completion(movieIDs)
                
            } catch {
                print("Error deserializing json: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
    }
    
    static func getMovie(with ID: String, completion: @escaping (_ movie: Movie?) -> Void) {
        
        guard let url = URL(string: baseURLString + ID) else {
            completion(nil)
            return
        }
        
        let urlParameters = ["api_key": apiKey, "append_to_response": "credits,videos"]
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters) { (data, error) in
        
            if let error = error {
                print("Unable to get movies ids: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No movie data was returned")
                completion(nil)
                return
            }
        }
    }
    
    static func getAllMovies(with IDs: [Double], completion: @escaping (_ movies: [Movie]) -> Void) {
        
        var allMovies: [Movie] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        
    }
}
