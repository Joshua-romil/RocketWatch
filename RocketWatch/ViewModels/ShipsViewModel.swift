//
//  ShipsViewModel.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-12-16.
//

import Foundation

protocol ShipViewModelDelegate: AnyObject{
    
    func didReceiveShipData()
    func didFailWithShipError(errorMessage: String)
    
}


class ShipsViewModel{
    
    var ships = [Ship]() //REST ships
    
    weak var delegate: ShipViewModelDelegate?
    
    private let shipService: ShipServiceProtocol
    
    init(shipService: ShipServiceProtocol = ShipService()) {
        self.shipService = shipService
    }

    func fetchShips(){
        ships.removeAll()
        Task {
            do {
                let ships = try await shipService.getShips()
                self.ships = ships
                self.delegate?.didReceiveShipData()
            } catch {
                self.delegate?.didFailWithShipError(errorMessage: error.localizedDescription)
            }
        }
    }
        
    func getShips() -> [Ship] {
        ships
    }
    
}
