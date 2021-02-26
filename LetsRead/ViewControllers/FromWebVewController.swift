//
//  FromWebVewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import WebKit

class FromWebVewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://clients.intertech.ps/yallaneqra/public/files/games/game_9/Match")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
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
extension FromWebVewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
