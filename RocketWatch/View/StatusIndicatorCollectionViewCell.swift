//
//  StatusIndicatorCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-02-20.
//

import UIKit

class StatusIndicatorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        statusLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layoutIfNeeded()
        
        
    }

}
