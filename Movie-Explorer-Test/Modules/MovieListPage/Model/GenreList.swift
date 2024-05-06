//
//  GenreList.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import Foundation

struct GenreList : Codable {
    
    var genres : [GenreInfo]?
    
    enum CodingKeys : String, CodingKey {
        case genres = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decodeIfPresent([GenreInfo].self, forKey: .genres)
    }
    
}
