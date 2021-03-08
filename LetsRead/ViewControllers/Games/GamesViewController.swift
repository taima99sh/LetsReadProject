//
//  GamesViewController.swift
//  LetsRead
//
//  Created by taima on 3/2/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
        getGames()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnSideMenu(_ sender: Any) {
        self.toggleRightViewAnimated(self)
    }
}
extension GamesViewController {
    func setupView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
    }
    func localized(){}
    func setupData(){}
    func fetchData(){}
    func getGames() {
        let request = BaseRequest()
        let stId = UserProfile.shared.userID ?? 0
        request.url = "videos?st_id=\(stId)"
        request.method = .get
        self.showIndicator()
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            self.hideIndicator()
            let data = VideoModel.init(fromJson: json)
            if data.success {
                if let videos = data.videos {
                    self.videos = videos
                    self.collectionView.reloadData()
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
}

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.object = self.videos[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "YoutubePlayerVIewController") as! YoutubePlayerVIewController
        vc.url = self.videos[indexPath.row].videoLink ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GamesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width - ( 30 + 30 + 30 )) / 2
            return CGSize.init(width: width, height: 180)
    }
}
