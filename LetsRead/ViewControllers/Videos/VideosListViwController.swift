//
//  VideosListViwController.swift
//  LetsRead
//
//  Created by taima on 2/28/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class VideosListViwController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        getMessages()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension VideosListViwController {
    func setupView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
    }
    func localized(){}
    func setupData(){}
    func getMessages() {
        let request = BaseRequest()
        let stId = UserProfile.shared.userID ?? 0
        request.url = UserProfile.shared.isUserLogin() ? "games?st_id=\(stId)" : "tripGames"
        request.method = .get
        self.showIndicator()
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            self.hideIndicator()
            let data = GamesModel.init(fromJson: json)
            if data.success {
                if let games = data.games {
                    self.games = games
                    self.collectionView.reloadData()
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
}


extension VideosListViwController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.gameObject = self.games[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FromWebVewController") as! FromWebVewController
        vc.title = games[indexPath.row].gameTitle
        vc.gameId = games[indexPath.row].gameId ?? 0
        vc.getGames()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension VideosListViwController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let height: CGFloat = 165
        let width: CGFloat = (UIScreen.main.bounds.size.width - ( 30 + 44 + 44 )) / 2
            return CGSize.init(width: width, height: 180)
    }
}
