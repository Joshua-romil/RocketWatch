//
//  Ship.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-08.
//

import Foundation

struct Ship: Codable{
    
    let id: String
    let name: String
    let image: String?
    let active: Bool
    let model: String?
    let roles: [ShipRole]
    let type: ShipType
    let massKg: Int?
    let massLbs: Int?
    let yearBuilt: Int?
    let homePort: HomePort
    let latitude: Double?
    let longitude: Double?
    
}

enum HomePort: String, Codable {
    case fortLauderdale = "Fort Lauderdale"
    case portCanaveral = "Port Canaveral"
    case portOfLosAngeles = "Port of Los Angeles"
}

enum ShipRole: String, Codable {
    case asdsBarge = "ASDS barge"
    case asdsTug = "ASDS Tug"
    case bargeTug = "Barge Tug"
    case dragonRecovery = "Dragon Recovery"
    case fairingRecovery = "Fairing Recovery"
    case supportShip = "Support Ship"
}

enum ShipType: String, Codable {
    case barge = "Barge"
    case cargo = "Cargo"
    case highSpeedCraft = "High Speed Craft"
    case tug = "Tug"
}
