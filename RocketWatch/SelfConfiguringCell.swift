//
//  SelfConfiguringCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-01-20.
//

import Foundation

protocol SelfConfiguringCell{
    static var reuseIdentifier: String {get}
    //func configure(with app: FeaturedItem)
}
