//
//  LocalDataService.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import Foundation

class LocalDataService {
    // The key for storing wishlist data in UserDefaults
    private let wishlistKey = "wishlistGames"

    // Save a game to the wishlist
    func saveToWishlist(game: Game) {
        var wishlist = getWishlist()
        if !wishlist.contains(where: { $0.id == game.id }) {
            wishlist.append(game)
            save(wishlist: wishlist)
        }
    }

    // Remove a game from the wishlist
    func removeFromWishlist(game: Game) {
        var wishlist = getWishlist()
        wishlist.removeAll { $0.id == game.id }
        save(wishlist: wishlist)
    }

    // Retrieve the wishlist
    func getWishlist() -> [Game] {
        if let data = UserDefaults.standard.data(forKey: wishlistKey) {
            let decoder = JSONDecoder()
            if let wishlist = try? decoder.decode([Game].self, from: data) {
                return wishlist
            }
        }
        return []
    }

    // Save the wishlist to UserDefaults
    private func save(wishlist: [Game]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(wishlist) {
            UserDefaults.standard.set(encoded, forKey: wishlistKey)
        }
    }
}

