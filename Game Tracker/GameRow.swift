//
//  GameRow.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import SwiftUI

struct GameRow: View {
    var game: Game

    var body: some View {
        HStack {
            // For preview purposes, use a system image. In production, you would load the image from the URL.
                        Image(systemName: game.backgroundImage) // Replace with `RemoteImage(url: game.backgroundImage)` for real URLs
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                Text("Release Date: \(formattedDate(game.releaseDate))")
                    .font(.subheadline)
                Text("Rating: \(game.rating, specifier: "%.1f") / 5")
                    .font(.subheadline)
            }
            .padding(.leading, 8)
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game.sampleGames[0])
    }
}
