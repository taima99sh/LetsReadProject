//
//  VideoCollectionViewCell.swift
//  LetsRead
//
//  Created by taima on 3/1/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVideo: UIImageView!
    @IBOutlet weak var playerView: UIView!
    
    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        if let obj = self.object as? Video {
            playerView.isHidden = false
            self.lblTitle.text = obj.videoTitle ?? ""
            let url = (obj.videoImg ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            self.imgVideo.LoadImageFromUrl(url: obj.videoImg ?? "")
        }
        if let obj = self.object as? Paint {
            playerView.isHidden = true
            self.lblTitle.text = obj.paintTitle ?? ""
            let url = (obj.paintImg ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            self.imgVideo.LoadImageFromUrl(url: url)
        }
        
        if let obj = self.object as? Game  {
            playerView.isHidden = true
            self.lblTitle.text = obj.gameTitle ?? ""
            let url = (obj.gameImg ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            self.imgVideo.LoadImageFromUrl(url: url)
        }
    }
}
