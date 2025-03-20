//
//  RocketService.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-19.
//

import Foundation

enum RocketServiceError: Error {
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

protocol RocketServiceProtocol {
    func getRockets() async throws -> [Rocket]
}

class RocketService: RocketServiceProtocol {
    
    private let endpoint = "https://api.spacexdata.com/v4/rockets"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getRockets() async throws -> [Rocket] {
        
        guard let url = URL(string: endpoint) else {
            throw RocketServiceError.invalidURL
        }
        
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw RocketServiceError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let rockets = try decoder.decode([Rocket].self, from: data)
            
            return rockets
            
        } catch {
            throw RocketServiceError.decodingError(error)
        }
        
    }
    
}
