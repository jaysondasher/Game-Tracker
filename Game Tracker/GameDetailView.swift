//
//  GameDetailView.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import SwiftUI


struct GameDetailView: View {
    var game: Game

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: game.backgroundImage)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .aspectRatio(contentMode: .fit)

                VStack(alignment: .leading, spacing: 10) {
                    Text(game.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Release Date: \(formattedDate(game.releaseDate))")
                        .font(.subheadline)

                    Text("Rating: \(game.rating, specifier: "%.1f") / 5")
                        .font(.subheadline)

                    Text(game.description ?? "No Description Provided")
                        .font(.body)
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(game.name), displayMode: .inline)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
