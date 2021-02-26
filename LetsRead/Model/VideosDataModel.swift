//
//  VideosDataModel.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class VideosDataModel: UIViewController {

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
extension VideosDataModel {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
