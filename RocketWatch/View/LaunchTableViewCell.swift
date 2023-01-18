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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellLabels(item: LaunchesQuery.Data.Launch){
        missionLabel.text = item.missionName
        siteLabel.text = item.launchSite?.siteName
        rocketLabel.text = item.rocket?.rocketName
    }
    
    func configureCellImage(item: LaunchesQuery.Data.Launch){
        
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
                    self.rocketImage.image = UIImage(systemName: "sparkle")
                }
                print("Launch is missing image")
            }else{
                DispatchQueue.main.async {
                    self.rocketImage.sd_setImage(with: launchImagesURLs![0], placeholderImage: UIImage(systemName: "sparkle"), context: [.imageThumbnailPixelSize : thumbnailSize])
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

