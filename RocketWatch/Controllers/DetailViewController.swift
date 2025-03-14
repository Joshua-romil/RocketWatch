//
//  RocketDetailViewController.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-02-01.
//

import UIKit
import SDWebImage
import MapKit

enum DetailType{
    case rocket
    case ship
}

class DetailViewController: UIViewController {
    
    var detailType: DetailType = .rocket
    var ship: Ship?
    let defaultImage = UIImage(systemName: "sailboat.fill")
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    private let aboutTextData: [String] = [
        "The Falcon 9 is a reusable two-stage rocket designed by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
        "It was first launched in June 2010 and has since become a key player in commercial spaceflight.",
        "The rocket is known for its first-stage booster landings, which enable cost reduction in space missions."
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.collectionViewLayout = createLayout()
        
        self.navigationItem.backButtonTitle = "Back"
        
        registerCarouselCell()
        registerStatusIndicatorCell()
        registerAboutCell()
        registerKeyFactsCell()
        registerPicturesHeader()
        registerMapCell()
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        
        if detailType == .ship{
            self.navigationItem.title = ship?.name ?? "Information"
        } else {
            self.navigationItem.title = "Falcon 9"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    private func registerCarouselCell(){
        self.detailCollectionView.register(UINib(nibName: "FeaturedCarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCarouselCollectionViewCell")
    }
    
    private func registerStatusIndicatorCell(){
        self.detailCollectionView.register(UINib(nibName: "StatusIndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StatusIndicatorCollectionViewCell")
    }
    
    private func registerAboutCell(){
        self.detailCollectionView.register(UINib(nibName: "AboutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AboutCollectionViewCell")
    }
    
    private func registerKeyFactsCell(){
        self.detailCollectionView.register(UINib(nibName: "KeyFactsCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "KeyFactsCollectionViewCell")
    }
    
    private func registerPicturesHeader(){
        self.detailCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    private func registerMapCell(){
        self.detailCollectionView.register(UINib(nibName: "MapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MapCollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        switch detailType {
        case .rocket:
            return 5 // Hero, Status indicator, About, Key Facts, Pictures
        case .ship:
            return 4 // Hero, Status indicator, Key Facts, Map
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0: return 1 // Hero
            case 1: return 1 // Status indicator
            case 2: return 1 // About
            case 3: return 1 // Key Facts
            case 4: return 4 // However many pictures you have
            case 5: return 1 // Map
            default: return 0
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            if self.detailType == .rocket{
                switch sectionIndex {
                    case 0: return self.createHeroSection()
                    case 1: return self.createStatusIndicatorSection()
                    case 2: return self.createAboutSection()
                    case 3: return self.createKeyFactsSection()
                    case 4: return self.createPicturesSection()
                    default: return nil
                }
            } else {
                switch sectionIndex {
                    case 0: return self.createHeroSection()
                    case 1: return self.createStatusIndicatorSection()
                    case 2: return self.createKeyFactsSection()
                    case 3: return self.createMapSection()
                    default: return nil
                }
            }
        }
    }
    
    private func createHeroSection() -> NSCollectionLayoutSection {
        
        //Feature section
        let featureItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let featureItem = [NSCollectionLayoutItem(layoutSize: featureItemLayoutSize)]
        let featureGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225))
        let featureGroup = NSCollectionLayoutGroup.horizontal(layoutSize: featureGroupLayoutSize, subitems: featureItem)
        let featureSection = NSCollectionLayoutSection(group: featureGroup)
        featureSection.orthogonalScrollingBehavior = .paging
        featureSection.contentInsets.bottom = 20
        
        return featureSection
    }
    
    private func createStatusIndicatorSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize( widthDimension: .absolute(115), heightDimension: .absolute(25))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(115),
            heightDimension: .absolute(25)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        
        return section
    }
    
    private func createAboutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200) // Enough space for the text
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        
        return section
    }
    
    private func createKeyFactsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100) // Adjust based on how many facts you have
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        
        return section
    }
    
    private func createPicturesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5), // Adjusted to fit 2 items in a row
            heightDimension: .fractionalWidth(0.5))
    
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
    
        // 2) Group (2 items per row)
        let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.5) // Same height as item for proper alignment
            )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        // 3) Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        
        //Label over section
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createMapSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        
        //Label over section
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }

}

extension DetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        switch detailType {
        case .rocket:
            
            switch indexPath.section {
            case 0:
                let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
                carouselCell.carouselImage.image = UIImage(named: "Falcon1")
                carouselCell.title.isHidden = true
                carouselCell.subtitle.isHidden = true
                return carouselCell
            case 1:
                let statusCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "StatusIndicatorCollectionViewCell", for: indexPath) as! StatusIndicatorCollectionViewCell
                return statusCell
            case 2:
                let aboutCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "AboutCollectionViewCell", for: indexPath) as! AboutCollectionViewCell
                return aboutCell
            case 3:
                let keyFactsCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "KeyFactsCollectionViewCell", for: indexPath) as! KeyFactsCollectionViewCell
                let keyFacts: [(field: String, fact: String)] = [
                            ("First Flight", "June 4, 2010"),
                            ("Height", "70 m"),
                            ("Diameter", "3.7 m"),
                            ("Mass", "549,054 kg"),
                            ("Stages", "2"),
                            ("Payload to LEO", "22,800 kg")
                        ]
                
                keyFactsCell.configure(with: keyFacts)
                
                return keyFactsCell
            case 4:
                let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
                carouselCell.carouselImage.image = UIImage(named: "Falcon1")
                carouselCell.title.isHidden = true
                carouselCell.subtitle.isHidden = true
                carouselCell.layer.cornerRadius = 8
                return carouselCell
            default:
                //this will be replaced anyway
                let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
                carouselCell.carouselImage.image = UIImage(named: "Falcon1")
                carouselCell.title.text = "hello world"
                carouselCell.subtitle.text = "hello world"
                return carouselCell
            }
            
            
        case .ship:
            
            switch indexPath.section {
            case 0:
                let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
                
                if let imageUrlString = ship?.image, let url = URL(string: imageUrlString){
                    carouselCell.carouselImage.sd_setImage(with: url)
                } else {
                    carouselCell.carouselImage.image = defaultImage
                }
                
                carouselCell.title.isHidden = true
                carouselCell.subtitle.isHidden = true
                return carouselCell
            case 1:
                let statusCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "StatusIndicatorCollectionViewCell", for: indexPath) as! StatusIndicatorCollectionViewCell
                if let ship = ship {
                    statusCell.configure(active: ship.active)
                } else {
                    statusCell.configure(active: false)
                }
                
                return statusCell
            case 2:
                let keyFactsCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "KeyFactsCollectionViewCell", for: indexPath) as! KeyFactsCollectionViewCell
                
                if let ship = ship {
                    
                    let weightString: String
                    
                    switch (ship.massKg, ship.massLbs) {
                        
                        case (let kg?, let lbs?): weightString = "\(kg)kg / \(lbs)lb"
                        case (let kg?, nil): weightString = "\(kg)kg"
                        case (nil, let lbs?): weightString = "\(lbs)lb"
                        case (nil, nil): weightString = "Unknown"
                        
                    }
                    
                    let keyFacts: [(field: String, fact: String)] = [
                        ("Home Port", ship.homePort.rawValue),
                                ("Roles", ship.roles.map { $0.rawValue }.joined(separator: ", ")),
                                ("Type", ship.type.rawValue),
                                ("Weight", weightString),
                                ("Year Built", ship.yearBuilt.map { String($0) } ?? "Unknown")
                    ]
                    
                    keyFactsCell.configure(with: keyFacts)
                    
                } else {
                    
                    let keyFacts: [(field: String, fact: String)] = [
                        ("Home Port", "Unknown"),
                        ("Roles", "None"),
                        ("Type", "Unknown"),
                        ("Weight", "Unknown"),
                        ("Year Built", "Unknown"),
                    ]
                    
                    keyFactsCell.configure(with: keyFacts)
                    
                }
                
                return keyFactsCell
            case 3:
                
                let mapCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath) as! MapCollectionViewCell
                if let ship = ship {
                    let coordinates: CLLocationCoordinate2D? = (ship.latitude != nil && ship.longitude != nil) ?
                            CLLocationCoordinate2D(latitude: ship.latitude!, longitude: ship.longitude!) :
                            nil
                    mapCell.configure(with: coordinates, homePort: ship.homePort)
                } else {
                    mapCell.configure(with: nil, homePort: .portCanaveral)
                }
                
                return mapCell
                
            default:
                let fallbackCell = UICollectionViewCell()
                return fallbackCell
            }
            
        default:
            let fallbackCell = UICollectionViewCell()
            return fallbackCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width - 32, height: 50))
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.textColor = .white
            headerView.subviews.forEach { $0.removeFromSuperview() } // Clear previous labels
            headerView.addSubview(label)
            
            if indexPath.section == 4 { // Pictures section
                label.text = "Pictures"
            }
            
            if indexPath.section == 3 { // Map section
                label.text = "Location"
            }
                
            return headerView
        }
            
        return UICollectionReusableView()
    }
}
