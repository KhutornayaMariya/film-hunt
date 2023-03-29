//
//  SearchResultViewModel.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 20.03.23.
//

import Foundation
import FilmHunt_Network

final class SearchResultViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case failed(NetworkError)
        case loaded
    }
    
    private enum Constants {
        static let moviesPerPage: Int = 10
    }
    
    @Published private(set) var state = State.idle
    @Published private(set) var searchResult: [MovieModel] = []
    @Published private(set) var isPaginating: Bool = false
    lazy var navigationTitle = {
        "\("SEARCH".localized): \(query)"
    }()
    
    private let query: String
    private let repository: SearchResultRepositoryProtocol
    private let movieModelFactory: MovieModelFactory
    
    private var totalPages: Int = 0
    private var currentPage: Int = 1
    
    
    init(query: String) {
        self.query = query
        self.repository = SearchResultRepository()
        self.movieModelFactory = MovieModelFactory()
    }
    
    private func calculateTotalPages(for result: String) {
        if let totalPage = Int(result) {
            self.totalPages = Int(ceil(Double(totalPage) / Double(Constants.moviesPerPage)))
        } else {
            self.totalPages = 0
        }
    }
}

extension SearchResultViewModel {
    
    @MainActor
    func fetchSearchResult() async {
        if !isPaginating {
            state = .loading
        }
        
        Task { [weak self] in
            guard let self = self else {
                self?.state = .failed(.unknown)
                return
            }
            do {
                let searchResult = try await repository.fetchSearchResult(by: query, page: currentPage)
                self.calculateTotalPages(for: searchResult.totalResults)
                var movies: [MovieModel] = []
                for item in searchResult.search {
                    let result = try await repository.fetchSearchResult(by: item.imdbID)
                    movies.append(movieModelFactory.createMovieModel(for: result))
                }
                self.searchResult.append(contentsOf: movies)
                if !isPaginating {
                    state = .loaded
                } else {
                    isPaginating = false
                }
            } catch {
                self.state = .failed(error as? NetworkError ?? .unknown)
                isPaginating = false
            }
        }
    }
    
    @MainActor
    func loadSearchResult(currentItem item: MovieModel) async {
        let thresholdIndex = searchResult.index(searchResult.endIndex, offsetBy: -1)
        let itemIndex = searchResult.firstIndex { $0.imdbID == item.imdbID }
        if thresholdIndex == itemIndex,(currentPage + 1) <= totalPages {
            isPaginating = true
            currentPage += 1
            await fetchSearchResult()
        }
    }
}
