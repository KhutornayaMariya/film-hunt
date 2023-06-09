//
//  SearchResultView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 20.03.23.
//

import SwiftUI
import FilmHunt_Network

struct SearchResultView: View {
    
    @ObservedObject var model: SearchResultViewModel
    
    var body: some View {
        NavigationStack {
            switch model.state {
            case .idle:
                Color.clear.onAppear(perform: loadSearchResult)
            case .loading:
                ProgressView()
            case .failed(let error):
                makeErrorView(error)
            case .loaded:
                makeLoadedView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(model.navigationTitle)
    }
}

// MARK: - Private methods

private extension SearchResultView {
    func makeLoadedView() -> some View {
        return List {
            ForEach(model.searchResult, id: \.imdbID) { movie in
                NavigationLink {
                    MovieDetailsView(model: MovieDetailsViewModel(movieModel: movie))
                } label: {
                    MovieItemView(model: movie)
                        .onAppear() {
                            loadMoreSearchResult(movie: movie)
                        }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .overlay {
            if model.isPaginating {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 110, height: 110)
                    ProgressView() {
                        Text("LOADING".localized)
                            .font(.title)
                    }
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                }
            }
        }
    }
    
    func makeErrorView(_ error: NetworkError) -> some View {
        let action: (() -> Void)? = error == .emptyResult ? nil : loadSearchResult
        return NetworkConnectionErrorView(error: error, action: action)
    }
    
    func loadSearchResult() {
        Task {
            await model.fetchSearchResult()
        }
    }
    
    func loadMoreSearchResult(movie: MovieModel) {
        Task {
            await model.loadSearchResult(currentItem: movie)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(model: SearchResultViewModel(query: "Friends"))
    }
}
