//
//  MovieDetailVC.swift
//  MovieSearch
//
//  Created by Roman Rozhok on 9/10/16.
//  Copyright © 2016 Roman Rozhok. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import ObjectMapper

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var metascoreLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    var movie: Movie!

    override func viewDidLoad() {
        
        // Set UI from passed in information
        titleLabel.text = movie.title
        posterImageView.kf.setImage(with: URL(string: movie.posterUrl)!, placeholder: UIImage(named: "blank_movie_poster.png"))
        
        getMovieDetails(movie.imdbID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Hide view
        contentView.isHidden = true
    }
    
    func updateUI(_ movie: Movie!){
        titleLabel.text = movie.title + " (" + movie.year + ")";
        posterImageView.kf.setImage(with: URL(string: movie.posterUrl)!, placeholder: UIImage(named: "blank_movie_poster.png"))
        ratingLabel.text = movie.rated
        runningTimeLabel.text = movie.runtime
        genreLabel.text = movie.genre
        plotLabel.text = movie.plot
        directorLabel.text = movie.director
        releasedLabel.text = movie.released
        imdbRatingLabel.text = movie.imdbRating + "/10"
        metascoreLabel.text = movie.metascore + "/100"
        actorsLabel.text = movie.actors
        awardsLabel.text = movie.awards
        writerLabel.text = movie.writer
    
    }
    
    func getMovieDetails(_ imdbID: String){
        // s - movie title search term
        // type - type of result to return - valid options: movie, series, episode
        let requestParams: Parameters = [
            "i": imdbID
        ]
        
        // request params have to be in order specified:
        Alamofire.request("https://www.omdbapi.com", method: .get, parameters: requestParams)
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    debugPrint(response.result)
                    
                    // Get JSON String from response
                    if let jsonResponse = response.result.value {
                        
                        // Map Json String to object with ObjectMapper
                        let movie = Mapper<Movie>().map(JSONString: jsonResponse )
                        
                        if let movie = movie {
                            self.movie = movie
                            self.updateUI(movie)
                            
                            // Show view
                            self.contentView.isHidden = false
                        } else {
                            // No results
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
