//
//  MovieInfo.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import Foundation

struct MovieInfo : Codable {
    
    var posterPath : String?
    
    enum CodingKeys : String, CodingKey {
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
}
