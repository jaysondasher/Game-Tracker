//
//  WishlistView.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import SwiftUI

struct WishlistView: View {
    // Replace these with your actual data source
    var availableGames: [Game] = Game.sampleGames
    var upcomingGames: [Game] = Game.sampleGames

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Currently Available")) {
                    ForEach(availableGames, id: \.id) { game in
                        GameRow(game: game)
                    }
                }

                Section(header: Text("Upcoming")) {
                    ForEach(upcomingGames, id: \.id) { game in
                        GameRow(game: game)
                    }
                }
            }
            .navigationBarTitle("Your Wishlist")
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
