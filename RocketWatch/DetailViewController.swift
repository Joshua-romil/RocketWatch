//
//  RocketDetailViewController.swift
//  RocketWatch
//
//  Created by Joshua George on 2025-02-01.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    private let aboutTextData: [String] = [
        "The Falcon 9 is a reusable two-stage rocket designed by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
        "It was first launched in June 2010 and has since become a key player in commercial spaceflight.",
        "The rocket is known for its first-stage booster landings, which enable cost reduction in space missions."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.collectionViewLayout = createLayout()
        
        registerCarouselCell()
        registerAboutCell()
        registerKeyFactsCell()
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        
    }
    

    private func registerCarouselCell(){

        self.detailCollectionView.register(UINib(nibName: "FeaturedCarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCarouselCollectionViewCell")
    }
    
    private func registerAboutCell(){
        self.detailCollectionView.register(UINib(nibName: "AboutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AboutCollectionViewCell")
    }
    
    private func registerKeyFactsCell(){
        self.detailCollectionView.register(UINib(nibName: "KeyFactsCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "KeyFactsCollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4 // Hero, About, Key Facts, Pictures
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: // Hero
            return 1
        case 1: // About
            return 1
        case 2: // Key Facts
            return 1
        case 3: // Pictures
            return 4 // However many pictures you have
        default:
            return 0
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                switch sectionIndex {
                case 0:
                    // Hero section
                    return self.createHeroSection()
                case 1:
                    // About section
                    return self.createAboutSection()
                case 2:
                    // Key Facts
                    return self.createKeyFactsSection()
                case 3:
                    // Pictures gallery
                    return self.createPicturesSection()
                default:
                    return nil
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
    private func createPicturesSection() -> NSCollectionLayoutSection {
        // 1) Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // 2) Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // 3) Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }

}

extension DetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
            carouselCell.carouselImage.image = UIImage(named: "Falcon1")
            carouselCell.title.isHidden = true
            carouselCell.subtitle.isHidden = true
            return carouselCell
        case 1:
            let aboutCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "AboutCollectionViewCell", for: indexPath) as! AboutCollectionViewCell
            return aboutCell
        case 2:
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
            
        default:
            let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
            carouselCell.carouselImage.image = UIImage(named: "Falcon1")
            return carouselCell
        }
        
        let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as! FeaturedCarouselCollectionViewCell
        carouselCell.carouselImage.image = UIImage(named: "Falcon1")
        return carouselCell
        
//        if indexPath.section == 0{
//            
//        }
        
//        if let carouselCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as? FeaturedCarouselCollectionViewCell{
//            
//            carouselCell.carouselImage.image = UIImage(named: "Falcon1")
//            
//            return carouselCell
//        }
        
        
    }
    
    
}
