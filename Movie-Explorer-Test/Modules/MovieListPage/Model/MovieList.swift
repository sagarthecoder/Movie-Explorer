//
//  MovieList.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import UIKit

struct MovieList : Codable {
    
    var results : [MovieInfo]?
    
    enum CodingKeys : String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decodeIfPresent([MovieInfo].self, forKey: .results)
    }
}
