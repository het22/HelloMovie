//
//  MovieListVC.swift
//  HelloMovie
//
//  Created by Het Song on 21/08/2019.
//  Copyright © 2019 Het Song. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var movieList: [Movie] = [] {
        didSet { movieListTableView.reloadData() }
    }
    var selectedMovie: Movie?
    var currentPage = 1
    
    @IBOutlet weak var movieListTableView: UITableView! {
        didSet {
            movieListTableView.dataSource = self
            movieListTableView.delegate = self
            movieListTableView.rowHeight = 120
            movieListTableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNowPlayingMovie(page: currentPage)
    }
    
    func requestNowPlayingMovie(page: Int) {
        Network.shared.AFRequestNowPlaying(page: currentPage) { [weak self] in
            self?.movieList.append(contentsOf: $0)
            self?.currentPage += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailVC = segue.destination as? MovieDetailViewController,
            let selectedMovie = self.selectedMovie {
            movieDetailVC.movie = selectedMovie
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell",
                                                 for: indexPath)
        let movie = movieList[indexPath.row]
        (cell as? MovieListTableViewCell)?.configure(movie: movie)
        
        let isEnd = indexPath.row == (movieList.count - 1)
        if isEnd { requestNowPlayingMovie(page: currentPage) }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movieList[indexPath.row]
        performSegue(withIdentifier: "ToMovieDetailVC", sender: self)
    }
}


