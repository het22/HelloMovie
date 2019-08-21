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
        Network.shared.AFRequestNowPlaying { [weak self] in self?.movieList = $0 }
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


