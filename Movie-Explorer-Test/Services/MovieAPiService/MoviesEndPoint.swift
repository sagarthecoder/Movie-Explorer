//
//  MoviesEndPoint.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import Foundation

enum MoviesEndpoint {
    
    case getGenreList
    case getAllMovies(id : Int)
    case getPopularMovies
}

extension MoviesEndpoint : Endpoint {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
            
        case .getGenreList:
            return "/3/genre/movie/list"
        case .getAllMovies(_):
            return "/3/discover/movie"
        case .getPopularMovies:
            return "/3/movie/popular"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        let apiKey = APIConfig.apiKey
        switch self {
        case .getAllMovies(let id):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "with_genres", value: "\(id)")
            ]
        default:
            return [
                URLQueryItem(name: "api_key", value: apiKey),
            ]
        }
    }
    
    var header: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
