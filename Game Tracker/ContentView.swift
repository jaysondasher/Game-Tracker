//
//  ContentView.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel() // Create a view model object

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else {
                        gameSection(title: "Most Anticipated", games: viewModel.mostAnticipatedGames)
                        gameSection(title: "Highest Rated All Time", games: viewModel.highestRatedAllTimeGames)
                        gameSection(title: "Highest Rated Last Year", games: viewModel.highestRatedLastYearGames)
                        gameSection(title: "Your Wishlist", games: viewModel.yourWishlistGames)
                    }
                }
            }
            .navigationBarTitle("Game Library", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
            })
            .onAppear {
                viewModel.fetchMostAnticipatedGames()
                viewModel.fetchHighestRatedAllTimeGames()
                viewModel.fetchHighestRatedLastYearGames() // Fetch games when the view appears
            }
        }
    }

    private func gameSection(title: String, games: [Game]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(games) { game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameRow(game: game)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

}

#Preview {
    ContentView()
}
