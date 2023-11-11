//
//  SplashViewController.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-01-07.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Change to 2 seconds when ready for app store.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0){
            self.performSegue(withIdentifier: "OpenMain", sender: nil)
        }
    }
    
//    private func featuredLaunchesSection() -> [FeaturedLaunchesSection] {
//        return (0...6).map {
//            FeaturedLaunchesSection(name: "Section \($0)", launches: (0...10).map {
//                
//                let randomSize = 200 * (Int.random(in: 1...12))
//                let imageURL = "http://placekitten.com/\(randomSize)/\(randomSize)"
//                
//                return FeaturedLaunch(name: "Launch \($0)", imageURL: URL(string: imageURL)!)
//            })
//        }
//    }

}
