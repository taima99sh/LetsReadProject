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
    
    var urlString: String = "http://clients.intertech.ps/yallaneqra/public/files/games/game_9/Match"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)!
        self.showIndicator()
        webView.load(URLRequest(url: url))
        
        if webView.isLoading {
            self.hideIndicator()
        }
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
