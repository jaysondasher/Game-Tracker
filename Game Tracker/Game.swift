//
//  Game.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import Foundation

struct Game: Identifiable, Codable {
    var id: Int
    var name: String
    var backgroundImage: String
    var released: String
    var rating: Double
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, description
        case backgroundImage = "background_image"
    }
    
    // Add a computed property to convert the release date string to Date
    var releaseDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Adjust this format to match the API's date format
        return formatter.date(from: released) ?? Date()
    }
}


extension Game {
    // Updated sample games for preview purposes
    static var sampleGames: [Game] {
        [
            Game(id: 1, name: "Game 1", backgroundImage: "gamecontroller", released: "2020-01-01", rating: 4.5, description: "Description for Game 1"),
            Game(id: 2, name: "Game 2", backgroundImage: "gamecontroller.fill", released: "2020-01-02", rating: 4.0, description: "Description for Game 2"),
            // Add more sample games as needed
        ]
    }
}
