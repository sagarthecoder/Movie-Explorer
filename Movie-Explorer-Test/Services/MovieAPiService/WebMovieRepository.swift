//
//  WebMovieRepository.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import UIKit


class WebMovieRepository: MovieRepository, HTTPClient {
    
    func getGenres(completion: @escaping ([GenreInfo]?) -> ()) {
        Task {
            let result = await sendRequest(endpoint: MoviesEndpoint.getGenreList, responseModel: GenreList.self)
            switch result {
            case .success(let genreList):
                guard let genres = genreList.genres else {
                    return
                }
                completion(genres)
                break
            case .failure(let error):
                print("failed to fetch Genres \(error.errorMessage)")
                completion(nil)
                break
            }
        }
    }
    
    func getMovies(genreID: Int, completion: @escaping ([MovieInfo]?) -> ()) {
        Task {
            let result = await sendRequest(endpoint: MoviesEndpoint.getAllMovies(id: genreID), responseModel: MovieList.self)
            
            switch result {
            case .success(let movieList):
                guard let movies = movieList.results else {
                    return
                }
                completion(movies)
                break
            case .failure(let error):
                print("failed to fetch genre wise Movies \(error.errorMessage)")
                completion(nil)
                break
            }
        }
    }
    
    func getPopularMovies(completion: @escaping ([MovieInfo]?) -> ()) {
        Task {
            let result = await sendRequest(endpoint: MoviesEndpoint.getPopularMovies, responseModel: MovieList.self)
            
            switch result {
            case .success(let movieList):
                guard let movies = movieList.results else {
                    return
                }
                completion(movies)
                break
            case .failure(let error):
                print("failed to fetch popular Movies \(error.errorMessage)")
                completion(nil)
                break
            }
        }
    }
    
    

}
