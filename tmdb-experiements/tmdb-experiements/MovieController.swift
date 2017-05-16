//
//  MovieController.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/15/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation

let apiKey = "2f8796b287c2f5c208d03dabe8515190"

class MovieController {
    
    var configuration: TMDBapiConfiguration? = nil
    var movieCollections: [String: [Movie]] = [:]
    
    static let shared = MovieController()
    
    static let baseURLString = "https://api.themoviedb.org/3/movie/"
    
    enum Endpoint {
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

    fileprivate static func constructURL(for endpoint: Endpoint) -> (url: URL, parameters: [String: String])? {
        guard var url = URL(string: baseURLString) else {
            return nil
        }
        
        var urlParameters = ["api_key": apiKey]
        
        var pathComponent: String
        switch endpoint {
        case .nowPlaying:
            pathComponent = endpoint.description
        case .popular:
            pathComponent = endpoint.description
        case .topRated:
            pathComponent = endpoint.description
        case .id:
            urlParameters["append_to_response"] = "credits,videos"
            pathComponent = endpoint.description
        }
        
        url.appendPathComponent(pathComponent)
        
        return (url, urlParameters)
    }
    
    static func getMovies(from endpoint: Endpoint, completion: @escaping (_ movies: [Movie]?) -> Void) {
        
        guard let requestComponents = constructURL(for: endpoint) else {
            completion(nil)
            return
        }
        
        NetworkController.performRequest(for: requestComponents.url, httpMethod: .get, urlParameters: requestComponents.parameters) { (data, error) in
            
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? jsonDictionary,
                    let moviesDictArray = json["results"] as? [jsonDictionary] else {
                    print("unexpected JSON format")
                    completion(nil)
                    return
                }
                
                let movies = moviesDictArray.flatMap { Movie(jsonDict: $0) }
                MovieController.shared.movieCollections[endpoint.description] = movies
                
                completion(movies)
                
            } catch {
                print("Error deserializing json: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
    }
    
    static func getDetails(for movie: Movie, completion: @escaping (_ movieJSON: jsonDictionary?) -> Void) {
        guard let requestComponents = constructURL(for: .id("\(movie.id)")) else {
            completion(nil)
            return
        }
        
        NetworkController.performRequest(for: requestComponents.url, httpMethod: .get, urlParameters: requestComponents.parameters) { (data, error) in
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? jsonDictionary else {
                    print("unexpected JSON format")
                    completion(nil)
                    return
                }
                
                completion(json)
                
            } catch {
                print("Error deserializing json: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
    }
}
