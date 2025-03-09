//
//  ShipService.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-09.
//

import Foundation

enum ShipServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}

protocol ShipServiceProtocol {
    func getShips() async throws -> [Ship]
}

class ShipService: ShipServiceProtocol {
    
    private let endpoint = "https://api.spacexdata.com/v4/ships"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getShips() async throws -> [Ship] {
        
        guard let url = URL(string: endpoint) else {
            throw ShipServiceError.invalidURL
        }
        
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
        
        // Fetch data
        let (data, response) = try await urlSession.data(for: request)
        
        // Validate response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ShipServiceError.invalidResponse
        }
        
        // Decode JSON into Ship array
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let ships = try decoder.decode([Ship].self, from: data)
            
            return ships
            
        } catch {
            throw ShipServiceError.decodingError(error)
        }
        
    }
    
}
