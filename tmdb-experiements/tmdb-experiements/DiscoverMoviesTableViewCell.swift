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

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension DiscoverMoviesTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension DiscoverMoviesTableViewCell: UICollectionViewDelegate {
    
}
