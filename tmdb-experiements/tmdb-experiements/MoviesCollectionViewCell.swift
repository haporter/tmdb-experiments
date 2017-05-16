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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with movie: Movie) {
        titleLabel.text = movie.title
        if let poster = movie.poster {
            posterImageView.image = poster
        }
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        
    }
}
