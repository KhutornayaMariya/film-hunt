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
    @State var isFiltered: Bool = false
    
    var body: some View {
        NavigationStack {
            switch model.state {
            case .idle:
                makeIdleView()
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
        .onChange(of: model.filters) { newValue in
            model.filters = newValue
            isFiltered = true
        }
    }
}

// MARK: - Private methods

private extension SearchResultView {
    
    func makeIdleView() -> some View {
        Color.clear
            .task {
                await model.fetchSearchResult()
            }
    }
    
    func makeLoadedView() -> some View {
        return List {
            ForEach(model.searchResult, id: \.imdbID) { movie in
                NavigationLink {
                    MovieDetailsView(model: MovieDetailsViewModel(movieModel: movie))
                } label: {
                    MovieItemView(model: movie)
                        .task {
                            if !isFiltered {
                                await model.loadSearchResult(currentItem: movie)
                            }
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: FiltersView(releaseRange: $model.filters)) {
                    Text("FILTERS".localized)
                        .font(.system(size: 17, weight: .medium, design: .default))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 15)
                        .frame(height: 34)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.black, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(model: SearchResultViewModel(query: "Friends"))
    }
}
