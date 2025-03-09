//
//  FeaturedCollectionViewCell.swift
//  RocketWatch
//
//  Created by Joshua George on 2023-01-25.
//

import UIKit
import SDWebImage

class FeaturedCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    private let defaultImage = UIImage(systemName: "sparkle")
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getImageLinks(launches: [LaunchesQuery.Data.Launch]) -> [String]{
        
        var launchesImageLinks: [String] = []
                 
        for launch in launches {
            if let flickrImages = launch.links?.flickrImages {
                for image in flickrImages {
                    if let image = image {
                        launchesImageLinks.append(image)
                    }
                }
            }
        }
        
        return launchesImageLinks
        
    }
    
    func getRandomFeaturedLaunches() -> [LaunchesQuery.Data.Launch]{
        
        let launches = appDelegate.launchViewModel.launchList
        let numberOfWantedFeaturedLaunches = 3
        var featuredLaunches: [LaunchesQuery.Data.Launch] = []
        var featuredLaunchImages: [String?]?
        
        
        while featuredLaunches.count < numberOfWantedFeaturedLaunches {
            
            let randomIndex = Int.random(in: 0...launches.count)
            let featuredLaunch = launches[randomIndex]
            
            featuredLaunchImages = featuredLaunch.links?.flickrImages
            
            let featuredLaunchImagesURLs = featuredLaunchImages?.compactMap {urlString -> URL? in
                if let urlString = urlString{
                    return URL(string: urlString)
                }else{
                    return nil
                }
            }
            
            if featuredLaunchImagesURLs!.isEmpty == false{
                featuredLaunches.append(featuredLaunch)
            }else{
                print("Ignoring launches that do not contain any images")
            }
            
        }
    
        return featuredLaunches
        
    }
    
    func configureShipCollectionViewCell(item: ShipsQuery.Data.Ship){
        
        let shipImageLink: String? = item.image
        let shipName: String? = item.name
        
        if let shipImageUrl = shipImageLink, let url = URL(string: shipImageUrl) {
            DispatchQueue.global(qos: .default).async {
                if url == nil{
                    DispatchQueue.main.async {
                        self.image.image = self.defaultImage
                    }
                    print("Ship image is missing")
                }else{
                    DispatchQueue.main.async {
                        self.image.sd_setImage(with: url)
                    }
                }

            }
        } else {
            print("Invalid URL")
        }
        
        if shipName != nil{
            self.label.text = shipName
        }else{
            print("Ship name does not exist")
        }
    }
    
}
