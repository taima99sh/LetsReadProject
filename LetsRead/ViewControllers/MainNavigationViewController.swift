//
//  MainNavigationViewController.swift
//  LetsRead
//
//  Created by taima on 2/24/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

  }
extension MainNavigationViewController {
    
    func setupView() {
        
        AppDelegate.shared.rootNavigationViewController = self
        if UserProfile.shared.isUserLogin() {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.setViewControllers([vc], animated: true)
        } else {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.setViewControllers([vc], animated: true)
        }
    }
    
    func localized() {
    }
    
    func setupData() {
    }
    
    func fetchData() {
    }
}
