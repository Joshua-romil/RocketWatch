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
    var shipsList = [ShipsQuery.Data.Ship]()
    weak var delegate: ShipViewModelDelegate?
    
    func fetchShipsList(){
        shipsList.removeAll()
        let apolloNetworkHelper = ApolloNetworkHelper.shared
        apolloNetworkHelper.graphQLType = .shipList
        apolloNetworkHelper.apolloClient.fetch(query: ShipsQuery()){ [weak self] result in
            
            switch result{
                case .success(let graphQLResult):
                    if let errors = graphQLResult.errors {
                        let message = errors.map{$0.localizedDescription}.joined(separator: "\n")
                        self?.delegate?.didFail(errorMessage: message)
                        return
                    }
                    if let shipConnection = graphQLResult.data?.ships{
                        self?.shipsList.append(contentsOf: shipConnection.compactMap{$0})
                    }
                    
                    //MOVE THIS TO THE RIGHT PLACE. BUT WHERE?
                    self?.delegate?.didReceiveData()
                case .failure(let error):
                    debugPrint("Error: \(error)")
                    self?.delegate?.didFail(errorMessage: error.localizedDescription)
            }
            
        }
            
    }
    
    func getShipsWithImages() -> [ShipsQuery.Data.Ship]{
        
        var shipsWithImages: [ShipsQuery.Data.Ship] = []
        
        for ship in shipsList{
            if ship.image == nil{
                continue;
            }
            shipsWithImages.append(ship)
        }
        print(shipsWithImages.count)
        return shipsWithImages
    }
    
}
