//
//  StatusIndicatorCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-02-20.
//

import UIKit

class StatusIndicatorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8
        circleView.layer.cornerRadius = circleView.frame.width / 2
        statusLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)

    }

}
