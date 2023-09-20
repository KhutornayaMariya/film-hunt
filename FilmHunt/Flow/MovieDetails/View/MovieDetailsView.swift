//
//  MovieDetailsView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 19.03.23.
//

import SwiftUI

struct MovieDetailsView: View {

    let model: MovieDetailsViewModel

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: model.movieModel.poster)!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(uiImage: UIImage(named: "placeholder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(width: 150, height: 200, alignment: .leading)
            .padding(.bottom)

            Text(model.movieModel.title)
                .fontWeight(.bold)
                .font(.title2)
                .padding(.bottom, 5)
                .multilineTextAlignment(.center)
            if model.isRating {
                HStack(spacing: 10) {
                    Text(model.imdbRating)
                        .foregroundColor(model.movieModel.ratingColor)
                        .font(.caption2)
                    Text(model.movieModel.imdbVotes)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            if !model.yearAndGenre.isEmpty {
                Text(model.yearAndGenre)
                    .font(.caption2)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
            if !model.countryAndRuntime.isEmpty {
                Text(model.countryAndRuntime)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
            }
            if !model.actors.isEmpty {
                Text(model.actors)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
            }

            if !model.movieModel.plot.isEmpty {
                Divider()

                Text(model.movieModel.plot)
                    .font(.caption)
            }

        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("New") {
                    print("Sort")
                }
                Button("New new") {
                    print("Filter")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(model.movieModel.title)
        .scrollIndicators(.hidden)
        .padding(16)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(model: MovieDetailsViewModel(movieModel: MovieModel(title: "Friends", year: "1994-2004", imdbID: "String", imdbRating: "8,5", ratingColor: .green, imdbVotes: "10000", type: "series", actors: "Jennifer Aniston, Courteney Cox, Lisa Kudrow", poster: "https://m.media-amazon.com/images/M/MV5BNDVkYjU0MzctMWRmZi00NTkxLTgwZWEtOWVhYjZlYjllYmU4XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg", plot: "Follows the personal and professional lives of six twenty to thirty year-old friends living in the Manhattan borough of New York City.", country: "USA", runtime: "20 min", genre: "Comedy, Romance")))
    }
}
