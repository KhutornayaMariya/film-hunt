//
//  SearchViewModel.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import Foundation
import FilmHunt_Network

final class SearchViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case failed(NetworkError)
        case loaded([MovieModel])
    }
    
    @Published private(set) var state = State.idle
    
    private let repository: SearchResultRepositoryProtocol
    private let movieModelFactory: MovieModelFactory
    
    private enum Constants {
        static let recommendations = ["tt0108778", "tt1475582",
                                      "tt0120689", "tt13833688",
                                      "tt0111161", "tt0903747",
                                      "tt0386676", "tt6710474"]
    }
    
    init() {
        self.repository = SearchResultRepository()
        self.movieModelFactory = MovieModelFactory()
    }
}

extension SearchViewModel {
    @MainActor
    func fetchRecomendations() async {
        state = .loading
        Task { [weak self] in
            do {
                var movies: [MovieModel] = []
                for id in Constants.recommendations {
                    let result = try await repository.fetchSearchResult(by: id)
                    movies.append(movieModelFactory.createMovieModel(for: result))
                }
                self?.state = .loaded(movies)
            } catch {
                self?.state = .failed(error as? NetworkError ?? .unknown)
            }
        }
    }
}
