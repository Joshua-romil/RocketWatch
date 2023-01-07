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

        //Change to 2 seconds when ready for appstore.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0){
            self.performSegue(withIdentifier: "OpenMain", sender: nil)
        }
    }

}
