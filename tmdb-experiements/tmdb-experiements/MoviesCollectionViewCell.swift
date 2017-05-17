//
//  MoviesCollectionViewCell.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
//        DispatchQueue.main.async {
//            self.updateAppearance(with: .none)
//        }
    }
    
    func updateAppearance(with movie: Movie?) {
        DispatchQueue.main.async {
            self.display(movie)
        }
    }
    
    private func display(_ movie: Movie?) {
        if let movie = movie {
            loadingIndicator.stopAnimating()
            self.titleLabel.text = movie.title
            if let poster = movie.poster {
                self.posterImageView.image = poster
            }
            self.posterImageView.alpha = 1
            self.titleLabel.alpha  = 1
            self.favoriteButton.alpha = 1
            self.addButton.alpha = 1
        } else {
            self.posterImageView.alpha = 0
            self.titleLabel.alpha = 0
            self.favoriteButton.alpha = 0
            self.addButton.alpha = 0
            self.loadingIndicator.alpha = 1
            self.loadingIndicator.startAnimating()
        }
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        
    }
}
