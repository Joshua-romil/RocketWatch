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
        circleView.clipsToBounds = false
        
        startRippleAnimation()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layoutIfNeeded()
    }
    
    private func startRippleAnimation() {
        
        let rippleLayer = CAShapeLayer()
        rippleLayer.path = UIBezierPath(ovalIn: circleView.bounds).cgPath
        rippleLayer.fillColor = UIColor.green.cgColor
        rippleLayer.opacity = 0.0
        rippleLayer.frame = circleView.bounds
        
        circleView.layer.addSublayer(rippleLayer)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 3      // Adjust to control how large the ripple gets
        scaleAnimation.duration = 1.5     // Duration of one ripple cycle
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.4
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = 1.5
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = 1.5
        animationGroup.repeatCount = Float.infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        rippleLayer.add(animationGroup, forKey: "rippleEffect")
    }

}
