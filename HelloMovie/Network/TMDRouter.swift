//
//  TMDRouter.swift
//  HelloMovie
//
//  Created by Het Song on 21/08/2019.
//  Copyright © 2019 Het Song. All rights reserved.
//

import Alamofire

enum TMDRouter: URLRequestConvertible {
    
    enum Constants {
        static let baseURLPath = "https://api.themoviedb.org/3/movie"
        static let authenticationToken = "API_KEY"
    }
    
    case NowPlaying(page: Int)
    case MovieDetail(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .NowPlaying: return .get
        case .MovieDetail: return .get
        }
    }
    
    var path: String {
        switch self {
        case .NowPlaying: return "now_playing"
        case .MovieDetail(let id): return "\(id)"
        }
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        params["api_key"] = Constants.authenticationToken
        params["language"] = "ko"
        switch self {
        case .NowPlaying(let page): params["page"] = page
        default: break
        }
        return params
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10*1000)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
