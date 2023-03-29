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
            SearchView(model: SearchViewModel())
        }
    }
}
