//
//  SearchView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    
    @ObservedObject var model: SearchViewModel
    @State private var query = ""
    @State private var showSearchResult = false
    
    
    var body: some View {
        NavigationStack {
            switch model.state {
            case .idle:
                Color.clear.onAppear(perform: loadInitialState)
            case .loading:
                ProgressView()
            case .failed(let error):
                NetworkConnectionErrorView(error: error, action: loadInitialState)
            case .loaded(let movie):
                makeRecommendationView(movie)
                
            }
        }
    }
}

// MARK: - Private methods

private extension SearchView {
    
    func makeRecommendationView(_ movies: [MovieModel]) -> some View {
        return List {
            Section("RECOMMENDATIONS_TITLE".localized) {
                ForEach(movies, id: \.imdbID) { movie in
                    NavigationLink {
                        MovieDetailsView(model: MovieDetailsViewModel(movieModel: movie))
                    } label: {
                        MovieItemView(model: movie)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: $query, prompt: "SEARCH_PLACEHOLDER".localized)
        .onSubmit(of: .search) {
            showSearchResult = true
        }
        .navigationDestination(isPresented: $showSearchResult) {
            SearchResultView(model: SearchResultViewModel(query: query))
        }
    }
    
    func loadInitialState() {
        Task {
            await model.fetchRecomendations()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(model: SearchViewModel())
    }
}
