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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.load(withVideoId: "A2m4wzDH05Q")
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
