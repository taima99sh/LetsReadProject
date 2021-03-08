//
//  PaintViewController.swift
//  LetsRead
//
//  Created by taima on 3/8/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var paints: [Paint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
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
extension PaintViewController {
    func setupView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
    }
    func localized(){}
    func setupData(){}
    func fetchData(){
        let request = BaseRequest()
        request.url = "tripDraw"
        request.method = .get
        self.showIndicator()
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            self.hideIndicator()
            let data = paintModel.init(fromJson: json)
            if data.success {
                if let paints = data.paints {
                    self.paints = paints
                    self.collectionView.reloadData()
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }

    }
}
extension PaintViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.object = self.paints[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FromWebVewController") as! FromWebVewController
        vc.urlString = self.paints[indexPath.row].paintHtml ?? ""
        vc.title = "يلا نرسم"
        vc.loaddingWebView(vc.urlString)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PaintViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width - ( 30 + 30 + 30 )) / 2
            return CGSize.init(width: width, height: 180)
    }
}
