//
//  RocketViewsModel.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-19.
//

import Foundation

protocol RocketViewModelDelegate: AnyObject{
    
    func didReceiveRocketData()
    func didFailWithRocketError(errorMessage: String)
    
}


class RocketsViewModel{
    
    var rockets = [Rocket]()
    
    weak var delegate: RocketViewModelDelegate?
    
    private let rocketService: RocketServiceProtocol
    
    init(rocketService: RocketServiceProtocol = RocketService()) {
        self.rocketService = rocketService
    }

    func fetchRockets(){
        rockets.removeAll()
        Task {
            do {
                let rockets = try await rocketService.getRockets()
                self.rockets = rockets
                self.delegate?.didReceiveRocketData()
            } catch {
                self.delegate?.didFailWithRocketError(errorMessage: error.localizedDescription)
            }
        }
    }
        
    func getRockets() -> [Rocket] {
        rockets
    }
    
}
