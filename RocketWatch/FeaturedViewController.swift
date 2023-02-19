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
        let topBannerSection = NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225)), subitems: [NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))]))
        topBannerSection.orthogonalScrollingBehavior = .continuous
        
        let contentSection = NSCollectionLayoutSection(group: NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)), subitems: [NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200)))]))
        
        let layout = UICollectionViewCompositionalLayout {(sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0{
                return topBannerSection
            } else {
                return contentSection
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
