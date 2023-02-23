//
//  FeaturedLaunchesViewController.swift
//  RocketWatch
//
//  Created by Hussein AlRyalat on 23/02/2023.
//

import UIKit

class FeaturedLaunchesViewController: UIViewController {
    static var headerIdentifier = "featured-launches-header"
    static var cellIdentifier = "featured-launches-cell"
    
    lazy var collectionView: UICollectionView = createCollectionView()
    
    let sections: [FeaturedLaunchesSection]
    
    init(sections: [FeaturedLaunchesSection]) {
        self.sections = sections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        collectionView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Featured"

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topConstraint = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        [leadingConstraint, trailingConstraint, topConstraint, bottomConstraint].forEach {
            $0.isActive = true
        }
    }
}

extension FeaturedLaunchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let launch = self.sections[indexPath.section].launches[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellIdentifier, for: indexPath) as! FeaturedLaunchCollectionViewCell
        
        cell.titleLabel.text = launch.name
        cell.imageView.sd_setImage(with: launch.imageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: Self.headerIdentifier, withReuseIdentifier: Self.headerIdentifier, for: indexPath) as! FeaturedLaunchesHeaderView
        
        header.titleLabel.text = sections[indexPath.section].name
        
        
        return header
    }
}

extension FeaturedLaunchesViewController {
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeaturedLaunchCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        collectionView.register(FeaturedLaunchesHeaderView.self, forSupplementaryViewOfKind: Self.headerIdentifier, withReuseIdentifier: Self.headerIdentifier)
        
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                              heightDimension: .absolute(220))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = itemSize
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: Self.headerIdentifier, alignment: .top)
        
        section.boundarySupplementaryItems = [
            sectionHeader
        ]
        
        let configurations = UICollectionViewCompositionalLayoutConfiguration()
        configurations.interSectionSpacing = 25
        
        return UICollectionViewCompositionalLayout(section: section, configuration: configurations)
    }
}
