//
//  AboutCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-02-18.
//

import UIKit

class AboutCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var aboutInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aboutInfo.numberOfLines = 15
        aboutInfo.textColor = .white
        aboutInfo.text = "The Falcon 9 is a reusable two-stage rocket designed by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit. It was first launched in June 2010 and has since become a key player in commercial spaceflight."
    }

}
