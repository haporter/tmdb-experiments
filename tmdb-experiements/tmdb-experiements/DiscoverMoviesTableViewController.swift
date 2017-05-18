//
//  DiscoverMoviesTableViewController.swift
//  tmdb-experiements
//
//  Created by Andrew Porter on 5/14/17.
//  Copyright © 2017 SwiftTech. All rights reserved.
//

import UIKit

class DiscoverMoviesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        MovieController.getMovies(from: .nowPlaying) { (movies) in
            if let movies = movies {
                print("I have this many now playing movies: \(movies.count)")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        MovieController.getMovies(from: .popular) { (movies) in
            if let movies = movies {
                print("I have this many popular movies: \(movies.count)")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        MovieController.getMovies(from: .topRated) { (movies) in
            if let movies = movies {
                print("I have this many top rated movies: \(movies.count)")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension DiscoverMoviesTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MovieController.shared.movieCollections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        switch section {
        case 0:
            title = "Now Playing"
        case 1:
            title = "Popular"
        case 2:
            title = "Top Rated"
        default:
            break
        }
        
        return title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCollectionCell", for: indexPath) as? DiscoverMoviesTableViewCell else { return UITableViewCell() }

        var movieCollectionKey = ""
        switch indexPath.section {
        case 0:
            movieCollectionKey = MovieController.Endpoint.nowPlaying.description
        case 1:
            movieCollectionKey = MovieController.Endpoint.popular.description
        case 2:
            movieCollectionKey = MovieController.Endpoint.topRated.description
        default:
            break
        }
        
        cell.update(with: movieCollectionKey)

        cell.parentViewController = self
        return cell
    }
}
