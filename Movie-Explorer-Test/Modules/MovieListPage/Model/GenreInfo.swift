//
//  GenreInfo.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import Foundation

struct GenreInfo : Codable {
    
    var id : Int?
    var name : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
}


