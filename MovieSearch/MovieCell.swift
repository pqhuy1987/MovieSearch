//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Roman Rozhok on 9/9/16.
//  Copyright © 2016 Roman Rozhok. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Disable cell highlight when selected
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ movie: Movie) {
        posterImageView.kf.setImage(with: URL(string: movie.posterUrl)!, placeholder: UIImage(named: "blank_movie_poster.png"))
        titleLabel.text = movie.title
        yearLabel.text = movie.year
    }
}
