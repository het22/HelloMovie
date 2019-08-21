//
//  MovieListTVC.swift
//  HelloMovie
//
//  Created by Het Song on 21/08/2019.
//  Copyright © 2019 Het Song. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet { posterImageView.contentMode = .scaleAspectFill }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(movie: Movie) {
        if let path = movie.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w200/\(path)")
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: nil)
        }
        titleLabel.text = movie.title
        releaseDateLabel.text = "개봉일: \(movie.release_date)"
        ratingLabel.text = "평점: \(movie.vote_average)점"
    }
}
