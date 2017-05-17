//
//  DataLoadOperation.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/16/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation

class DataLoadOperation: Operation {
    var movie: Movie?
    var loadingCompleteHandler: ((Movie) -> ())?
    
    private let _movie: Movie
    
    init(_ movie: Movie) {
        _movie = movie
    }
    
    override func main() {
        self.movie = _movie
        guard let movie = movie else { return }
        
        if isCancelled { return }
        
        movie.loadPoster()
        
        if let loadingCompleteHandler = loadingCompleteHandler {
            DispatchQueue.main.async {
                loadingCompleteHandler(self._movie)
            }
        }
    }
}
