//
//  LaunchTableViewCell.swift
//  TestGraphQL
//
//  Created by Joshua George on 2022-11-30.
//

import UIKit
import SDWebImage

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var rocketImage: UIImageView!
    
    public var launchImagesURLs: [URL] = []
    private let defaultImage = UIImage(systemName: "sparkle")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTableViewCellLabels(item: LaunchesQuery.Data.Launch){
        missionLabel.text = item.missionName
        siteLabel.text = item.launchSite?.siteName
        rocketLabel.text = item.rocket?.rocketName
    }
    
    func configureTableViewCellImage(item: LaunchesQuery.Data.Launch){
        
        let launchImagesLinks: [String?]? = item.links?.flickrImages
        let scale = UIScreen.main.scale
        let thumbnailSize = CGSize(width: 80 * scale, height: 80 * scale)
                
        let launchImagesURLs = launchImagesLinks?.compactMap { urlString -> URL? in
            if let urlString = urlString {
                return URL(string: urlString)
            } else {
                return nil
            }
        }
        
        DispatchQueue.global(qos: .default).async {
            if launchImagesURLs!.isEmpty{
                DispatchQueue.main.async {
                    self.rocketImage.image = self.defaultImage
                }
                print("Launch is missing image")
            }else{
                DispatchQueue.main.async {
                    self.rocketImage.sd_setImage(with: launchImagesURLs![0], placeholderImage: self.defaultImage, context: [.imageThumbnailPixelSize : thumbnailSize])
                    self.rocketImage.setRounded()
                }
            }
        }
        
    }
    
}

extension UIImageView {

    func setRounded() {
        self.layer.cornerRadius = (self.frame.height / 2)
        self.layer.masksToBounds = true
    }
}

