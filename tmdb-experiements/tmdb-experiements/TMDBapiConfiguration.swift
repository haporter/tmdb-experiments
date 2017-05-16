//
//  TMDBapiConfiguration.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/16/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation

struct TMDBapiConfiguration {
    
    private let kBaseImageURL = "secure_base_url"
    private let kBackdropSizes = "backdrop_sizes"
    private let kPosterSizes = "poster_sizes"
    
    private let baseImageURLString: String
    private let backdropSizes: [String]
    private let posterSizes: [String]
    
    
    init?(jsonDict: jsonDictionary) {
        
        guard let baseImageURLString = jsonDict[kBaseImageURL] as? String,
            let backdropSizes = jsonDict[kBackdropSizes] as? [String],
            let posterSizes = jsonDict[kPosterSizes] as? [String]
            else { return nil }
        
        self.baseImageURLString = baseImageURLString
        self.backdropSizes = backdropSizes
        self.posterSizes = posterSizes
    }
    
    func posterURLMedium() -> URL? {
        guard let url = URL(string: baseImageURLString) else { return nil }
        // FIXME: - I realize this is unsafe and needs refactoring
        return url.appendingPathComponent(posterSizes[4])
    }
    
    func backdropURLMedium() -> URL? {
        guard let url = URL(string: baseImageURLString) else { return nil }
        // FIXME: - I realize this is unsafe and needs refactoring
        return url.appendingPathComponent(backdropSizes[1])
    }
}
