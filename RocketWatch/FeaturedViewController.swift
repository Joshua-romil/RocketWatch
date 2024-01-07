//
//  FeaturedViewController.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-01-18.
//

import UIKit

struct CarouselCell{
    let title: String
    let subtitle: String
    let image: UIImage
}
 
class FeaturedViewController: UIViewController{

    @IBOutlet weak var featuredCollectionView: UICollectionView!
    
    var dataSource: UICollectionViewDataSource?
    var pageControl: UIPageControl?
    var launchViewModel: LaunchViewModel = LaunchViewModel()
    
    var carouselCells: [CarouselCell] = [
        CarouselCell(title: "Falcon 1 Rocket", subtitle: "Kennedy Space Center Launch Complex", image: UIImage(named: "Falcon1")!),
        CarouselCell(title: "Falcon 9 Rocket", subtitle: "Testing purpose", image: UIImage(named: "Falcon9")!),
        CarouselCell(title: "Latest Flight Was a Blast", subtitle: "SpaceX team successfully launched Starship", image: UIImage(named: "Starship")!)]

    static var headerIdentifier = "featured-launches-header"
    static var pageControlIdentifier = "featured-page-control"
    static var cellIdentifier = "featured-launches-cell"
        
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Anropa createLayout() bara om du vill använda orginalet
        featuredCollectionView.collectionViewLayout = createLayout()
        
        registerHeader()
        registerCell()
        registerPageControl()
        registerCarouselCell()
        
        featuredCollectionView.dataSource = self
        featuredCollectionView.delegate = self
        
    }
    
    private func registerHeader(){
        self.featuredCollectionView.register(FeaturedLaunchesHeaderView.self, forSupplementaryViewOfKind: Self.headerIdentifier, withReuseIdentifier: Self.headerIdentifier)
    }
    
    private func registerPageControl(){
        self.featuredCollectionView.register(FeaturedHeaderPageControl.self, forSupplementaryViewOfKind: Self.pageControlIdentifier, withReuseIdentifier: Self.pageControlIdentifier)
    }
    
    private func registerCell(){
        self.featuredCollectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
    }
    
    private func registerCarouselCell(){
        self.featuredCollectionView.register(UINib(nibName: "FeaturedCarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCarouselCollectionViewCell")
    }

    
    private func createLayout() -> UICollectionViewLayout{

        //Feature section
        let featureItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let featureItem = [NSCollectionLayoutItem(layoutSize: featureItemLayoutSize)]
        let featureGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225))
        let featureGroup = NSCollectionLayoutGroup.horizontal(layoutSize: featureGroupLayoutSize, subitems: featureItem)
        let featureSection = NSCollectionLayoutSection(group: featureGroup)
        featureSection.orthogonalScrollingBehavior = .paging
        featureSection.contentInsets.bottom = 20
        //featureSection.
    
        
        //Rocket section
        let rocketItemLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(230))
        let rocketItem = NSCollectionLayoutItem(layoutSize: rocketItemLayoutSize)
        let rocketGroupLayoutSize = rocketItemLayoutSize
        let rocketGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rocketGroupLayoutSize, subitems: [rocketItem])
        let rocketSection = NSCollectionLayoutSection(group: rocketGroup)
        rocketSection.orthogonalScrollingBehavior = .paging
        rocketSection.interGroupSpacing = 20
        rocketSection.contentInsets = .init(top: 10, leading: 20, bottom: 30, trailing: 20)
        
        
        //Label over section
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: Self.headerIdentifier, alignment: .topLeading)
        
        //UIPageControl
        let pageControlSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let pageControl = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: pageControlSize, elementKind: Self.pageControlIdentifier, alignment: .bottom)
        
        featureSection.visibleItemsInvalidationHandler = { items, contentOffset, environment in
            let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
            self.pageControl?.currentPage = currentPage
        }
        
        featureSection.boundarySupplementaryItems = [
            pageControl
        ]
        
        rocketSection.boundarySupplementaryItems = [
            sectionHeader
        ]
        
        //Compositional Layout
        let layout = UICollectionViewCompositionalLayout {(sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0{
                return featureSection
            } else {
                return rocketSection
            }
        }
        
        return layout
    }
    
    //An experimental function based on the youtube-video iOS 13 Compositional Layout Food Delivery Layout
    private func createLayout2() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { sectionNumber, env in
            
            if sectionNumber == 0{
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 0
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
            } else {
                let rocketItemLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
                let rocketItem = NSCollectionLayoutItem(layoutSize: rocketItemLayoutSize)
                let rocketGroupLayoutSize = rocketItemLayoutSize
                let rocketGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rocketGroupLayoutSize, subitems: [rocketItem])
                let rocketSection = NSCollectionLayoutSection(group: rocketGroup)
                rocketSection.orthogonalScrollingBehavior = .paging
                rocketSection.interGroupSpacing = 20
                rocketSection.contentInsets = .init(top: 10, leading: 10, bottom: 30, trailing: 10)
                
                //Label over section
                let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: Self.headerIdentifier, alignment: .top)

                rocketSection.boundarySupplementaryItems = [
                    sectionHeader
                ]
                
                return rocketSection
            }
            
        }
    }
    
}


extension FeaturedViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //Featured header section
        if section == 0 {
            return 3
        }
        
        //Rockets section
        if section == 1 {
            return 4
        }
        
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Carousel section
        if indexPath.section == 0
        {
            
            if let carouselCell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCarouselCollectionViewCell", for: indexPath) as? FeaturedCarouselCollectionViewCell{
                
                carouselCell.carouselImage.alpha = 0.3
                
                switch indexPath.row {
                case 0:
                    carouselCell.carouselImage.image = carouselCells[0].image
                    carouselCell.title.text = carouselCells[0].title
                case 1:
                    carouselCell.carouselImage.image = carouselCells[1].image
                    carouselCell.title.text = carouselCells[1].title
                case 2:
                    carouselCell.carouselImage.image = carouselCells[2].image
                    carouselCell.title.text = carouselCells[2].title
                default:
                    break
                }
                
                return carouselCell
            }
        }
        else //Rockets + ships section
        {
            if let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as? FeaturedCollectionViewCell{
                
                let rockets = appDelegate.rocketViewModel.rocketsList
                let rocketName = rockets[indexPath.item].name
                
                let featuredHeaderSubtitle: UILabel = UILabel(frame: cell.frame)
                
                featuredHeaderSubtitle.textAlignment = .center
                featuredHeaderSubtitle.textColor = .white
                
                if indexPath.section != 0{
                    cell.layer.cornerRadius = 16
                    cell.clipsToBounds = true
                }
                
                //Rockets section
                if indexPath.section == 1 {
                    cell.rocketImage.alpha = 1
                    cell.rocketLabel.text = rocketName
                    cell.rocketLabel.textColor = .white
                    
                    switch rocketName {
                    case "Falcon 1":
                        cell.rocketImage.image = UIImage(named: "Falcon1")
                    case "Falcon 9":
                        cell.rocketImage.image = UIImage(named: "Falcon9")
                    case "Falcon Heavy":
                        cell.rocketImage.image = UIImage(named: "FalconHeavy")
                    case "Starship":
                        cell.rocketImage.image = UIImage(named: "Starship")
                    default:
                        cell.rocketImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(systemName: "sparkle"))
                    }
                
                }
                
                //Ships section
                if indexPath.section == 2{
                    //TODO: Create functionality for displaying ships
                }
                            
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                
        if kind == Self.headerIdentifier{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Self.headerIdentifier, withReuseIdentifier: Self.headerIdentifier, for: indexPath) as! FeaturedLaunchesHeaderView
            print(indexPath.section)
            
            if indexPath.section == 1 {
                header.titleLabel.text = "Rockets"
            }else if indexPath.section == 2{
                header.titleLabel.text = "Ships"
            }
            
            header.titleLabel.textColor = .white
            
            return header
        }
        
        let pageControl = collectionView.dequeueReusableSupplementaryView(ofKind: Self.pageControlIdentifier, withReuseIdentifier: Self.pageControlIdentifier, for: indexPath) as! FeaturedHeaderPageControl
        
        self.pageControl = pageControl.pageControl
        
        return pageControl

    }
}
