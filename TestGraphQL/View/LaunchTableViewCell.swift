//
//  LaunchTableViewCell.swift
//  TestGraphQL
//
//  Created by Joshua George on 2022-11-30.
//

import UIKit

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
    
    func configureCell(item: LaunchesQuery.Data.Launch){
        missionLabel.text = item.missionName
        siteLabel.text = item.launchSite?.siteName
        rocketLabel.text = item.rocket?.rocketName
        
        let launchImagesLinks: [String?]? = item.links?.flickrImages
        
        if launchImagesLinks!.isEmpty{
            //TODO: Show default image when there are no launch images available
        } else{
            //TODO: Show first launch image when there are launch images available
        }
        
        let launchImagesURLs = launchImagesLinks?.compactMap { urlString -> URL? in
            if let urlString = urlString {
                return URL(string: urlString)
            } else {
                return nil
            }
        }
        
    }
    
}
