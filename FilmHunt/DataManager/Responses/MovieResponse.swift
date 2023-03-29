//
//  MovieResponse.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import Foundation

struct MovieResponse: Decodable {
    
    let title: String
    let year: String
    let imdbID: String
    let imdbRating: String
    let imdbVotes: String
    let type: String
    let actors: String
    let poster: String
    let plot: String
    let country: String
    let runtime: String
    let genre: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case imdbRating
        case imdbVotes
        case type = "Type"
        case actors = "Actors"
        case poster = "Poster"
        case plot = "Plot"
        case country = "Country"
        case runtime = "Runtime"
        case genre = "Genre"
    }
}
