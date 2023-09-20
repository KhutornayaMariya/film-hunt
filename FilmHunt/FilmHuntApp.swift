//
//  FilmHuntApp.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 16.03.23.
//

import SwiftUI

@main
struct FilmHuntApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView(model: SearchViewModel())
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }

                ProfileView()
                    .tabItem {
                        Label("", systemImage: "house")
                    }
            }
        }
    }
}
