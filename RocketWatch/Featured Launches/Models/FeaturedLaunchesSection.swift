//
//  FeaturedLaunchesSection.swift
//  RocketWatch
//
//  Created by Hussein AlRyalat on 23/02/2023.
//

import Foundation

struct FeaturedLaunchesSection: Codable {
    let name: String
    let launches: [FeaturedLaunch]
}
