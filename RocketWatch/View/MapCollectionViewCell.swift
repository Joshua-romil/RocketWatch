//
//  MapCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-03.
//

import UIKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("View is initiazed but has nothing to view!")
    }

}
