//
//  SearchResponse.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import Foundation

struct SearchResponse: Decodable {
    
    let search: [Search]
    let totalResults: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
    }
}

extension SearchResponse {
    
    struct Search: Decodable {
        let title: String
        let year: String
        let imdbID: String
        let type: String
        let poster: String
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID
            case type = "Type"
            case poster = "Poster"
        }
    }
}
