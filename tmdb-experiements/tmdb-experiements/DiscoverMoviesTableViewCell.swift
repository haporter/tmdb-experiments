//
//  DiscoverMoviesTableViewCell.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

class DiscoverMoviesTableViewCell: UITableViewCell {
    
    let loadingQueue = OperationQueue()
    var loadingOperations = [Int: DataLoadOperation]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie]?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.prefetchDataSource = self
    }
    
    func update(with key: String) {
        
        if let movies = MovieController.shared.movieCollections[key] {
            self.movies = movies
        }
        
        collectionView.reloadData()
    }

}

extension DiscoverMoviesTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionViewCell, let movies = movies else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.item]
        if let _ = movie.poster {
            cell.updateAppearance(with: movie)
        } else {
            cell.updateAppearance(with: .none)
        }
        return cell
    }
}

extension DiscoverMoviesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCollectionViewCell, let currentMovie = movies?[indexPath.item] else { return }
        
        let updateCellClosure: (Movie?) -> () = { [unowned self] (movie) in
            cell.updateAppearance(with: movie)
            self.loadingOperations.removeValue(forKey: currentMovie.id)
        }
        
        if let dataLoader = loadingOperations[currentMovie.id] {
            if let movie = dataLoader.movie, let _ = movie.poster {
                cell.updateAppearance(with: movie)
                loadingOperations.removeValue(forKey: currentMovie.id)
            } else {
                dataLoader.loadingCompleteHandler = updateCellClosure
            }
        } else {
            if let dataLoader = currentMovie.loadOperation() {
                dataLoader.loadingCompleteHandler = updateCellClosure
                loadingQueue.addOperation(dataLoader)
                loadingOperations[currentMovie.id] = dataLoader
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.item] else { return }
        if let dataLoader = loadingOperations[movie.id] {
            dataLoader.cancel()
            loadingOperations.removeValue(forKey: movie.id)
        }
    }
}

extension DiscoverMoviesTableViewCell: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let movie = movies?[indexPath.item] else { return }
            if let _ = loadingOperations[movie.id] {
                return
            }
            if let dataLoader = movie.loadOperation() {
                loadingQueue.addOperation(dataLoader)
                loadingOperations[movie.id] = dataLoader
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let movie = movies?[indexPath.item] else { return }
            if let dataLoader = loadingOperations[movie.id] {
                dataLoader.cancel()
                loadingOperations.removeValue(forKey: movie.id)
            }
        }
    }
}
