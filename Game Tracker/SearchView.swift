//
//  SearchView.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [Game] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.id) { game in
                    GameRow(game: game)
                }
            }
            .navigationBarTitle("Search Games")
            .navigationBarItems(trailing:
                Button("Search") {
                    // Trigger the search functionality
                    performSearch()
                }
            )
            .searchable(text: $searchText, prompt: "Search for a game")
        }
    }

    private func performSearch() {
        // Implement search functionality here
        // Call RAWG API and update searchResults based on the response
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
