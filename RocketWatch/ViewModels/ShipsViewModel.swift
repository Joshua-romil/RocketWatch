//
//  ShipsViewModel.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-12-16.
//

import Foundation

protocol ShipViewModelDelegate: AnyObject{
    
    func didReceiveData()
    func didFail(errorMessage: String)
    
}


class ShipsViewModel{
    
    var shipsList = [ShipsQuery.Data.Ship]() //GraphQL ships (based on a different API)
    var restShipsList = [Ship]() //REST ships
    
    weak var delegate: ShipViewModelDelegate?
    
    private let shipService: ShipServiceProtocol
    
    init(shipService: ShipServiceProtocol = ShipService()) {
        self.shipService = shipService
    }

    func fetchRestShipsList(){
        restShipsList.removeAll()
        Task {
            do {
                let ships = try await shipService.getShips()
                self.restShipsList = ships
                self.delegate?.didReceiveData()
            } catch {
                self.delegate?.didFail(errorMessage: error.localizedDescription)
            }
        }
    }
        
    func getRESTShips() -> [Ship] {
        restShipsList
    }
    
}
