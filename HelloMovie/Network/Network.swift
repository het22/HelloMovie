//
//  Network.swift
//  HelloMovie
//
//  Created by Het Song on 21/08/2019.
//  Copyright © 2019 Het Song. All rights reserved.
//

import Alamofire

class Network {
    
    static let shared = Network()
    
    func AFRequestNowPlaying(page: Int, completion: @escaping ([Movie])->Void) {
        Alamofire
            .request(TMDRouter.NowPlaying(page: page))
            .validate()
            .responseData { response in
                if let result = response.result.value {
                    do {
                        let movies = try JSONDecoder().decode(Movies.self, from: result).results
                        completion(movies)
                    } catch {
                        print(error)
                    }
                }
            }
    }
    
    func AFRequestMovieDetail(id: Int, completion: @escaping (MovieDetail)->Void) {
        Alamofire
            .request(TMDRouter.MovieDetail(id: id))
            .validate()
            .responseData { response in
                if let result = response.result.value {
                    do {
                        let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: result)
                        completion(movieDetail)
                    } catch {
                        print(error)
                    }
                }
        }
    }
}
