//
//  KeyFactsCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-02-18.
//

import UIKit

class KeyFactsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var keyFactsStackView: UIStackView!
    @IBOutlet weak var keyFactsHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        keyFactsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
    }
    
    func configure(with facts: [(field: String, fact: String)]) {
        
        keyFactsStackView.addArrangedSubview(keyFactsHeaderLabel)
        
        for factPair in facts {
            let factView = createFactView(field: factPair.field, fact: factPair.fact)
            keyFactsStackView.addArrangedSubview(factView)
        }
    }
    
    private func createFactView(field: String, fact: String) -> UIView {
        let factView = UIStackView()
        factView.axis = .horizontal
        factView.distribution = .fill
        factView.alignment = .fill
        factView.spacing = 8
        
        let fieldLabel = UILabel()
        fieldLabel.text = "\(field):"
        fieldLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let factLabel = UILabel()
        factLabel.text = fact
        factLabel.numberOfLines = 0
        factLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        factView.addArrangedSubview(fieldLabel)
        factView.addArrangedSubview(factLabel)

        return factView
    }

}
