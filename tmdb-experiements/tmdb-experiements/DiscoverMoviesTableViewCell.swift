//
//  DiscoverMoviesTableViewCell.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

class DiscoverMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var key: String?
    var movies: [Movie]?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with key: String) {
        self.key = key
        
        if let movies = MovieController.shared.movieCollections[key] {
            self.movies = movies
        }
        
        self.collectionView.reloadData()
    }

}

extension DiscoverMoviesTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        
        if let key = key, let movies = MovieController.shared.movieCollections[key] {
            count = movies.count
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionViewCell, let movies = movies else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.item]
        cell.update(with: movie)
        return cell
    }
}

extension DiscoverMoviesTableViewCell: UICollectionViewDelegate {
    
}
