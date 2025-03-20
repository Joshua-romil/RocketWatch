//
//  RocketsLaunchViewModel.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-07-17.
//

import Foundation
import Apollo


class RocketsLaunchViewModel{
    var rocketsList = [RocketsQuery.Data.Rocket]()
    weak var delegate: LaunchViewModelDelegate?
    

    func fetchRocketList(){
        rocketsList.removeAll()
        let apolloNetworkHelper = ApolloNetworkHelper.shared
        apolloNetworkHelper.graphQLType = .launchList
        apolloNetworkHelper.apolloClient.fetch(query: RocketsQuery()){ [weak self] result in
            
            switch result{
                case .success(let graphQLResult):
                    if let errors = graphQLResult.errors {
                        let message = errors.map{$0.localizedDescription}.joined(separator: "\n")
                        self?.delegate?.didFail(errorMessage: message)
                        return
                    }
                    if let launchConnection = graphQLResult.data?.rockets{
                        self?.rocketsList.append(contentsOf: launchConnection.compactMap{$0})
                    }
                
                    //MOVE THIS TO THE RIGHT PLACE. BUT WHERE?
                    self?.delegate?.didReceiveData()
                case .failure(let error):
                    debugPrint("Error: \(error)")
                    self?.delegate?.didFail(errorMessage: error.localizedDescription)
            }
        }
    }
}
