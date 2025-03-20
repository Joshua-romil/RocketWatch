//
//  Rocket.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-19.
//

import Foundation

struct Rocket: Codable {
    
    let id: String
    let name: String
    let flickrImages: [String]
    let active: Bool
    let description: String
    let firstFlight: String
    let height, diameter: Diameter
    let mass: Mass
    let costPerLaunch: Int
    let country: String
    let company: String

}

struct Diameter: Codable {
    let meters, feet: Double?
}

struct Mass: Codable {
    let kg, lb: Int
}
