//
//  NetworkConnectionErrorView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import SwiftUI
import FilmHunt_Network

struct NetworkConnectionErrorView: View {
    
    let error: NetworkError
    let action: (() -> Void)?
    
    private enum Constants {
        static let stackSpacing: CGFloat = 20
        static let imageWidth: CGFloat = 85
        static let imageHeight: CGFloat = 60
    }
    
    var body: some View {
        VStack(spacing: Constants.stackSpacing) {
            Image(systemName: error.errorImage())
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: Constants.imageWidth,
                       height: Constants.imageHeight)
            Text(error.errorMessage())
                .multilineTextAlignment(.center)
                .font(.title3)
            if let action = action {
                Button("REFRESH".localized) {
                    action()
                }
                .buttonStyle(.bordered)
                .tint(.yellow)
            }
        }
        .padding()
    }
}

struct NetworkConnectionErrorView_Previews: PreviewProvider {
    
    static var previews: some View {
        NetworkConnectionErrorView(error: .emptyResult) {
            print("Button was tapped")
        }
    }
}
