//
//  FeaturedCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-01-25.
//

import UIKit
import SDWebImage

class FeaturedCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var rocketImage: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureTemplateCollectionViewCell(){
        rocketLabel.text = "Hellaw"
        //rocketImage.image = UIImage(systemName: "Sparkle")
    }
    


    
    
}
