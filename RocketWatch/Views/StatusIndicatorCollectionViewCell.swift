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
    
    private var rippleLayer: CAShapeLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        statusLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = false
        
    }
    
    func configure(active: Bool){
        
        let activeBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 238/255, alpha: 1)
        let activeLabelColor = UIColor(red: 85/255, green: 190/255, blue: 126/255, alpha: 1)
        
        let inactiveBackgroundColor = UIColor(red: 255/255, green: 233/255, blue: 233/255, alpha: 1)
        let inactiveLabelColor = UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1)
    
        
        if active {
            
            statusLabel.text = "In Service"
            
            statusLabel.textColor = activeLabelColor
            circleView.backgroundColor = activeLabelColor
            containerView.backgroundColor = activeBackgroundColor
                        
            if rippleLayer == nil {
                startRippleAnimation()
            }
            
        } else {
            
            rippleLayer?.removeFromSuperlayer()
            rippleLayer = nil
            
            statusLabel.text = "Inactive"
            
            statusLabel.textColor = inactiveLabelColor
            circleView.backgroundColor = inactiveLabelColor
            containerView.backgroundColor = inactiveBackgroundColor
            
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layoutIfNeeded()
    }
    
    private func startRippleAnimation() {
        
        rippleLayer = CAShapeLayer()
        
        rippleLayer!.path = UIBezierPath(ovalIn: circleView.bounds).cgPath
        rippleLayer!.fillColor = UIColor.green.cgColor
        rippleLayer!.opacity = 0.0
        rippleLayer!.frame = circleView.bounds
        
        circleView.layer.addSublayer(rippleLayer!)
        
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
        
        rippleLayer!.add(animationGroup, forKey: "rippleEffect")
    }

}
