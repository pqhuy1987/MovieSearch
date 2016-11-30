//
//  MainViewController.swift
//  MovieSearch
//
//  Created by Roman Rozhok on 9/9/16.
//  Copyright © 2016 Roman Rozhok. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Set view delegates
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self;
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "showMovieDetail", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let destinationVC = segue.destination as? MovieDetailVC {
                if let movie = sender as? Movie {
                    destinationVC.movie = movie
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configureCell(self.movies[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide keyboard
        view.endEditing(true)
        
        let searchText = searchBar.text!
        
        // s - movie title search term
        // type - type of result to return - valid options: movie, series, episode
        let requestParams: Parameters = [
            "s": searchText,
            "type": "movie"
        ]
        
        Alamofire.request("https://www.omdbapi.com", method: .get, parameters: requestParams)
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    debugPrint(response.result)
                    
                    // Get JSON String from response
                    if let jsonResponse = response.result.value {
                        
                        // Map Json String to object with ObjectMapper
                        let movieSearchResult = Mapper<MovieSearchResult>().map(JSONString: jsonResponse)
                        
                        if let movieResults = movieSearchResult?.movies {
                            self.movies = movieResults
                            self.tableView.reloadData()
                            self.scrollToFirstRow()
                        } else {
                            // No results
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

