//
//  YoutubePlayerVIewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerVIewController: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    var url: String = ""
    var id :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sIndex = url.lastIndex(of: "=") {
            let index = url.index(after: sIndex)
            id = String(url.suffix(from: index))
        }
        self.showIndicator()
        playerView.load(withVideoId: id)
        self.hideIndicator()
        setupView()
        localized()
        setupData()
        fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension YoutubePlayerVIewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
