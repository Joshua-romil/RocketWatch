//
//  LaunchViewModel.swift
//  TestGraphQL
//
//  Created by Joshua George on 2022-11-30.
//

import Foundation
import Apollo

protocol LaunchViewModelDelegate: AnyObject{
    
    func didReceiveData()
    func didFail(errorMessage: String)
    
}

class LaunchViewModel{
    var launchList = [LaunchesQuery.Data.Launch]()
    weak var delegate: LaunchViewModelDelegate?
    
    func fetchLaunchList(){
        launchList.removeAll()
        let apolloNetworkHelper = ApolloNetworkHelper.shared
        apolloNetworkHelper.graphQLType = .launchList
        apolloNetworkHelper.apolloClient.fetch(query: LaunchesQuery()){ [weak self] result in
            
            switch result{
                case .success(let graphQLResult):
                    debugPrint("graphQLResult: \(graphQLResult)")
                if let errors = graphQLResult.errors {
                    let message = errors.map{$0.localizedDescription}.joined(separator: "\n")
                    self?.delegate?.didFail(errorMessage: message)
                    return
                }
                if let launchConnection = graphQLResult.data?.launches{
                    self?.launchList.append(contentsOf: launchConnection.compactMap{$0})
                }
                self?.delegate?.didReceiveData()
            case .failure(let error):
                debugPrint("Error: \(error)")
                self?.delegate?.didFail(errorMessage: error.localizedDescription)
            }
            
        }
    }
}
