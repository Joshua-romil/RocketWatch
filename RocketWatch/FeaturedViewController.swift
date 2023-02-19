//
//  FeaturedViewController.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-01-18.
//

import UIKit

class FeaturedViewController: UIViewController{

    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    
    
    var dataSource: UICollectionViewDataSource?
    var launchViewModel: LaunchViewModel = LaunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featuredCollectionView.collectionViewLayout = createLayout()
        
        registerCell()
        
        featuredCollectionView.dataSource = self
        featuredCollectionView.delegate = self
    }
    
    private func registerCell(){
        self.featuredCollectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
    }
    
    private func createLayout() -> UICollectionViewLayout{

        //Feature section
        let featureItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let featureItem = [NSCollectionLayoutItem(layoutSize: featureItemLayoutSize)]
        let featureGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225))
        let featureGroup = NSCollectionLayoutGroup.horizontal(layoutSize: featureGroupLayoutSize, subitems: featureItem)
        let featureSection = NSCollectionLayoutSection(group: featureGroup)
        featureSection.orthogonalScrollingBehavior = .continuous
        
        
        //Rocket section
        let rocketItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
        let rocketItem = [NSCollectionLayoutItem(layoutSize: rocketItemLayoutSize)]
        let rocketGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let rocketGroup = NSCollectionLayoutGroup.vertical(layoutSize: rocketGroupLayoutSize, subitems: rocketItem)
        let rocketSection = NSCollectionLayoutSection(group: rocketGroup)
        rocketSection.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout {(sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0{
                return featureSection
            } else {
                return rocketSection
            }
        }
        
        return layout
    }


}


extension FeaturedViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as? FeaturedCollectionViewCell{
            cell.configureTemplateCollectionViewCell()
            return cell
        }

        return UICollectionViewCell()
    }
    
    
}
