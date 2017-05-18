//
//  DataLoadOperation.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/16/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import Foundation


class DataLoadOperation: Operation {
    var movie: Movie
    var loadingCompleteHandler: ((Movie) -> ())?
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    override func main() {
        
        if isCancelled { return }
        
        self.movie.loadPoster()
        
        if let loadingCompleteHandler = loadingCompleteHandler {
            DispatchQueue.main.async {
                loadingCompleteHandler(self.movie)
            }
        }
    }
}








