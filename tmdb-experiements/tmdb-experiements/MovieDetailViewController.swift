//
//  MovieDetailViewController.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
