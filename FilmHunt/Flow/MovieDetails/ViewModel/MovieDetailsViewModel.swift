//
//  MovieDetailsViewModel.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 20.03.23.
//

import Foundation
import SwiftUI

final class MovieDetailsViewModel {
    
    let movieModel: MovieModel
    
    lazy var isRating: Bool = {
        return movieModel.imdbRating != nil
    }()
    
    lazy var imdbRating: String = {
        movieModel.imdbRating ?? ""
    }()
    
    lazy var actors: String = {
        movieModel.actors.isEmpty ? "" : "\("ACTORS".localized): \(movieModel.actors)"
    }()
    
    lazy var countryAndRuntime : String  = {
        if movieModel.country.isEmpty,
           movieModel.runtime.isEmpty {
            return ""
        } else if movieModel.runtime.isEmpty {
            return movieModel.country
        } else if movieModel.country.isEmpty {
            return movieModel.runtime
        }
        return "\(movieModel.country), \(movieModel.runtime)"
    }()
    
    lazy var yearAndGenre : String  = {
        if movieModel.year.isEmpty,
           movieModel.genre.isEmpty {
            return ""
        } else if movieModel.year.isEmpty {
            return movieModel.genre
        } else if movieModel.year.isEmpty {
            return movieModel.genre
        }
        return "\(movieModel.year), \(movieModel.genre)"
    }()
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
}
