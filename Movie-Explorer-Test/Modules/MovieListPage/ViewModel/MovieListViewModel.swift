//
//  MovieListViewModel.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import UIKit

class MovieListViewModel {
    
    var movieRepository : MovieRepository
    
    init(movieRepository : MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func getGenres(completion : @escaping (_ genres : [GenreInfo])->()) {
        movieRepository.getGenres { genres in
            guard let genres = genres else {
                return
            }
            completion(genres)
        }
    }
    
    func getMovies(genreID : Int, completion : @escaping (_ movies : [MovieInfo])->()) {
        movieRepository.getMovies(genreID: genreID) { movies in
            guard let movies = movies else {
                return
            }
            completion(movies)
        }
    }
    
    func getPopularMovies(completion : @escaping (_ movies : [MovieInfo])->()) {
        movieRepository.getPopularMovies { movies in
            guard let movies = movies else {
                return
            }
            completion(movies)
        }
    }
    
}
