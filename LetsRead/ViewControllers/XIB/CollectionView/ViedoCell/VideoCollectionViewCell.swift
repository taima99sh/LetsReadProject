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
    
    var object: Video?
    var gameObject: Game?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        if let obj = self.object {
            playerView.isHidden = false
            self.lblTitle.text = obj.videoTitle ?? ""
            let url = (obj.videoImg ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            self.imgVideo.LoadImageFromUrl(url: obj.videoImg ?? "")
        }
        if let obj = gameObject {
            playerView.isHidden = true
            self.lblTitle.text = obj.gameTitle ?? ""
            let url = (obj.gameImg ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            self.imgVideo.LoadImageFromUrl(url: url)
        }
    }
}
