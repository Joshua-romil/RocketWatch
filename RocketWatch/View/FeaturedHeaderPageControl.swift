//
//  FeaturedHeaderPageControl.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-09-30.
//

import UIKit

class FeaturedHeaderPageControl: UICollectionReusableView {
    
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(pageControl)
        
        pageControl.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        pageControl.numberOfPages = 3 // Set the total number of pages
        pageControl.currentPage = 0
        pageControl.tintColor = .gray // Set the color of inactive dots
        pageControl.currentPageIndicatorTintColor = .white // Set the color of the active dot
        
        // Center the page control horizontally
       pageControl.translatesAutoresizingMaskIntoConstraints = false //setting this property to false, means we are using autolayout
       NSLayoutConstraint.activate([
           pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
           pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55),
       ])
    }

        
}
