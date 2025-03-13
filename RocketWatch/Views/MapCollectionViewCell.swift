//
//  MapCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-03-03.
//

import UIKit
import MapKit


// Create a custom annotation class that conforms to MKAnnotation.
class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class MapCollectionViewCell: UICollectionViewCell, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //retrieve coordinates from ship object.
        let shipCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let region = MKCoordinateRegion(center: shipCoordinate, latitudinalMeters: 8000, longitudinalMeters: 8000)
        
        mapView.delegate = self
        mapView.layer.cornerRadius = 5
        
        addShipAnnotation(coordinate: shipCoordinate, region: region)
       
    }
    

    func addShipAnnotation(coordinate: CLLocationCoordinate2D, region: MKCoordinateRegion) {
        
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "shipMarker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
            annotationView?.glyphImage = UIImage(systemName: "sailboat.fill")
            annotationView?.markerTintColor = .black
            annotationView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
        
    }

    
    func configure(with coordinates: CLLocationCoordinate2D?, homePort: HomePort) {
        
        var finalCoordinates = CLLocationCoordinate2D()
        
        if coordinates == nil {
            switch homePort {
            case .fortLauderdale:
                finalCoordinates = CLLocationCoordinate2D(latitude: 26.092163, longitude: -80.120157)
            case .portCanaveral:
                finalCoordinates = CLLocationCoordinate2D(latitude: 28.415151, longitude: -80.630438)
            case .portOfLosAngeles:
                finalCoordinates = CLLocationCoordinate2D(latitude: 33.736717, longitude: -118.265098)
            }
            
            let region = MKCoordinateRegion(center: finalCoordinates, latitudinalMeters: 8000, longitudinalMeters: 8000)
            let portAnnotation = CustomAnnotation(coordinate: finalCoordinates, title: "Port", subtitle: "Port location")
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(portAnnotation)
            
        } else {
            
            let region = MKCoordinateRegion(center: coordinates!, latitudinalMeters: 8000, longitudinalMeters: 8000)
            let portAnnotation = CustomAnnotation(coordinate: coordinates!, title: "Ship", subtitle: "Ship position")
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(portAnnotation)
            
        }
        
    }
    
}
