//
//  GameViewModel.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var mostAnticipatedGames: [Game] = []
    @Published var highestRatedAllTimeGames: [Game] = []
    @Published var highestRatedLastYearGames: [Game] = []
    @Published var yourWishlistGames: [Game] = []
    @Published var isLoading = false

    private var rawgService: RAWGService
    private var localDataService: LocalDataService

    init(rawgService: RAWGService = RAWGService(), localDataService: LocalDataService = LocalDataService()) {
            self.rawgService = rawgService
            self.localDataService = localDataService
            fetchMostAnticipatedGames()
            fetchHighestRatedAllTimeGames()
            fetchHighestRatedLastYearGames()
            fetchWishlistGames()
        }

    func fetchMostAnticipatedGames() {
        isLoading = true
        rawgService.fetchGames(ordering: "-added", dates: "2022-01-01,2022-12-31") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let games):
                    self?.mostAnticipatedGames = games
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func fetchHighestRatedAllTimeGames() {
        isLoading = true
        rawgService.fetchGames(ordering: "-rating") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let games):
                    self?.highestRatedAllTimeGames = games
                    print("Successfully loaded highest rated all-time games.")
                case .failure(let error):
                    print("Error fetching highest rated all-time games: \(error.localizedDescription)")
                }
            }
        }
    }


    func fetchHighestRatedLastYearGames() {
        isLoading = true
        // Set the dates to the previous year
        let lastYear = Calendar.current.component(.year, from: Date()) - 1
        rawgService.fetchGames(ordering: "-rating", dates: "\(lastYear)-01-01,\(lastYear)-12-31") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let games):
                    self?.highestRatedLastYearGames = games
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchWishlistGames() {
            yourWishlistGames = localDataService.getWishlist()
        }
    
    func addToWishlist(game: Game) {
            localDataService.saveToWishlist(game: game)
            fetchWishlistGames() // Refresh the wishlist games
        }

    func removeFromWishlist(game: Game) {
            localDataService.removeFromWishlist(game: game)
            fetchWishlistGames() // Refresh the wishlist games
        }
}
