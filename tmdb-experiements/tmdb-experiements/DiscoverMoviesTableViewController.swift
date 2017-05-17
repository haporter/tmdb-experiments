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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        // #warning Incomplete implementation, return the number of rows
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

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
