//
//  MovieDetailVC.swift
//  HelloMovie
//
//  Created by Het Song on 21/08/2019.
//  Copyright © 2019 Het Song. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    var movieDetail: MovieDetail? {
        didSet { if let detail = movieDetail { configure(detail: detail) } }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.shared.AFRequestMovieDetail(id: movie.id) { [weak self] in
            self?.movieDetail = $0
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet { posterImageView.contentMode = .scaleAspectFill }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    func configure(detail: MovieDetail) {
        if let path = movie.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(path)")
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: nil)
        }
        titleLabel.text = detail.title
        subtitleLabel.text = detail.tagline
        detailLabel.text = "개봉일 \(detail.release_date) | 상영시간 \(detail.runtime)분 | 평점 \(detail.vote_average)점"
        overviewTextView.text = detail.overview
    }
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
