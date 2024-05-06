//
//  MovieRepository.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import UIKit

protocol MovieRepository {
    
    func getGenres(completion : @escaping (_ genres : [GenreInfo]?)->())
    func getMovies(genreID : Int, completion : @escaping (_ movies : [MovieInfo]?)->())
    func getPopularMovies(completion : @escaping (_ movies : [MovieInfo]?)->())
    
}
