//
//  RAWGService.swift
//  Game Tracker
//
//  Created by Jayson Dasher on 1/21/24.
//

import Foundation

class RAWGService {
    let apiKey: String = "ee25ccb74e51456e835e238acdbafcb9"
    let baseURL = "https://api.rawg.io/api/games"


    func fetchGames(ordering: String? = nil, dates: String? = nil, completion: @escaping (Result<[Game], Error>) -> Void) {
            var components = URLComponents(string: baseURL)!
            var queryItems = [URLQueryItem(name: "key", value: apiKey)]

            if let ordering = ordering {
                queryItems.append(URLQueryItem(name: "ordering", value: ordering))
            }

            if let dates = dates {
                queryItems.append(URLQueryItem(name: "dates", value: dates))
            }

            components.queryItems = queryItems

            guard let url = components.url else {
                completion(.failure(URLError(.badURL)))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    // Handle no data error
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }

                do {
                    let gamesResponse = try JSONDecoder().decode(GamesResponse.self, from: data)
                    completion(.success(gamesResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }

// You will need a corresponding data model to decode the response
struct GamesResponse: Codable {
    var results: [Game]
}
