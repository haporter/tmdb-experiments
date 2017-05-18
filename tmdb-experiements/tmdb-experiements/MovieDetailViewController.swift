//
//  MovieDetailViewController.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearRatingLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            update(with: movie)
        }
    }
    
    func update(with movie: Movie) {
        
        navBar.title = movie.title
        
        titleLabel.text = movie.title
        posterImageView.image = movie.poster
        bannerImageView.image = movie.backdrop
        runTimeLabel.text = "\(movie.runtime! / 60) hours \(movie.runtime! % 60) minutes"
        userRatingLabel.text = "\(movie.userRating)/10"
        yearRatingLabel.text = movie.year
        synopsisLabel.text = movie.synopsis
        
        var genreString = ""
        for genre in movie.genres {
            let formattedGenreString = genre.replacingOccurrences(of: "\"", with: "")
            genreString += formattedGenreString + ", "
        }
        genreLabel.text = String(genreString.characters.dropLast(2))
        directorLabel.text = movie.director
        
        var castString = ""
        for member in movie.cast {
            castString += member + ", "
        }
        castLabel.text = String(castString.characters.dropLast(2))
    }
}
