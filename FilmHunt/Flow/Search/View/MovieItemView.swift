//
//  MovieItemView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 16.03.23.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImage

struct MovieItemView: View {
    
    let model: MovieModel
    
    var body: some View {
        HStack {
            /* TODO: Replace SDWebImage usage with AsyncImage
             whenever its performance is improved (see an example
             https://developer.apple.com/forums/thread/682498)
             */
            WebImage(url: URL(string: model.poster)!)
                .resizable()
                .placeholder(Image(uiImage: UIImage(named: "placeholder")!))
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(model.title)
                    .fontWeight(.bold)
                    .font(.caption)
                    .lineLimit(1)
                Text(model.year)
                    .font(.caption2)
                    .lineLimit(1)
                Text(model.country + " • " + model.genre)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 5)
            Spacer()
            if let rating = model.imdbRating {
                Text(rating)
                    .foregroundColor(model.ratingColor)
                    .fontWeight(.bold)
                    .frame(alignment: .trailing)
            }
        }
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(model: MovieModel(title: "Friends", year: "1994-2004", imdbID: "String", imdbRating: "8,5", ratingColor: .green, imdbVotes: "10000", type: "series", actors: "Jennifer Aniston, Courteney Cox, Lisa Kudrow", poster: "https://m.media-amazon.com/images/M/MV5BNDVkYjU0MzctMWRmZi00NTkxLTgwZWEtOWVhYjZlYjllYmU4XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg", plot: "Follows the personal and professional lives of six twenty to thirty year-old friends living in the Manhattan borough of New York City.", country: "USA", runtime: "20 min", genre: "Comedy, Romance"))
    }
}
