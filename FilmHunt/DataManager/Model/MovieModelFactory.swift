//
//  MovieModelFactory.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 19.03.23.
//

import Foundation
import SwiftUI

final class MovieModelFactory {
    
    func createMovieModel(for response: MovieResponse) -> MovieModel {
        return MovieModel(title: response.title,
                          year: isUnknown(response.year),
                          imdbID: response.imdbID,
                          imdbRating: rating(response.imdbRating),
                          ratingColor: ratingColor(response.imdbRating),
                          imdbVotes: imdbVotes(response.imdbVotes),
                          type: response.type,
                          actors: isUnknown(response.actors),
                          poster: response.poster,
                          plot: isUnknown(response.plot),
                          country: isUnknown(response.country),
                          runtime: runtime(response.runtime),
                          genre: response.genre
        )
    }
    
    private func rating(_ string: String) -> String? {
        guard let _ = Float(string) else {
            return nil
        }
        return string
    }
    
    private func ratingColor(_ rating: String) -> Color {
        guard let numberRating = Float(rating) else {
            return .gray
        }
        
        if numberRating >= 7 {
            return .green
        }  else if numberRating >= 5{
            return .gray
        } else {
            return .red
        }
    }
    
    func imdbVotes(_ string: String) -> String {
        let newString = string.replacingOccurrences(of: ",", with: "")
        guard let votes = Int(newString),
              votes > 999
        else {
            return isUnknown(string)
        }
        
        let kiloVotes = String(votes / 1000)
        return kiloVotes + "KILO".localized
    }
    
    func runtime(_ string: String) -> String {
        let minutesInHour = 60
        let newString = string.replacingOccurrences(of: " min", with: "")
        guard let totalMinutes = Int(newString),
              totalMinutes >= minutesInHour else {
            return isUnknown(string)
        }
        
        let hours = totalMinutes / minutesInHour
        let minutes = totalMinutes % minutesInHour
                
        return "\(hours) \("HOUR".localized) \(minutes) \("MIN".localized)"
    }
    
    func isUnknown(_ string: String) -> String {
        return string == "N/A" ? "" : string
    }
}
