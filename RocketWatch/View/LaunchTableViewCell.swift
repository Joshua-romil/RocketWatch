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
    
    func configureCellLabels(item: LaunchesQuery.Data.Launch){
        missionLabel.text = item.missionName
        siteLabel.text = item.launchSite?.siteName
        rocketLabel.text = item.rocket?.rocketName
    }
    
    func configureCellImage(item: LaunchesQuery.Data.Launch){
        
        let launchImagesLinks: [String?]? = item.links?.flickrImages
        
        let launchImagesURLs = launchImagesLinks?.compactMap { urlString -> URL? in
            if let urlString = urlString {
                return URL(string: urlString)
            } else {
                return nil
            }
        }
        
        
        DispatchQueue.global(qos: .background).async {
            if launchImagesURLs!.isEmpty{
                print("Error: Launch is missing image")
            }else{
                do{
                    let data = try Data.init(contentsOf: launchImagesURLs![0])
                    DispatchQueue.main.async {
                        self.rocketImage.image = UIImage(data: data)
                        self.rocketImage.setRounded()
                    }
                }
                catch{
                    print("Unexpected error: \(error).")
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

