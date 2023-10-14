//
//  FeaturedLaunchesSection.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-04-07.
//

import Foundation

struct FeaturedLaunchesSection: Codable {
    let name: String
    let launches: [FeaturedLaunch]
}
