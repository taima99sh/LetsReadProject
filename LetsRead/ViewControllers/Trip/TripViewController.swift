//
//  TripViewController.swift
//  LetsRead
//
//  Created by taima on 3/4/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {


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
    
    @IBAction func btnStories(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPaint(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FromWebVewController") as! FromWebVewController
        vc.urlString = "http://clients.intertech.ps/yallaneqra/public/files/paints/paint_4/Draw"
        vc.title = "يلا نرسم"
        vc.loaddingWebView(vc.urlString)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnGames(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "VideosListViwController") as! VideosListViwController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension TripViewController {
    func setupView(){
       self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
