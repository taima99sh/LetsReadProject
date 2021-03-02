//
//  MenuViewController.swift
//  LetsRead
//
//  Created by taima on 2/24/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import LGSideMenuController

var isloggedIn: Bool = false

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: GeneralTableView!
    
    let loginArr: [Constant.MenuItems] = [.library, .test, .videos, .games, .help, .messages, .SignOut]
    let notLoginArr: [Constant.MenuItems] = [.home, .aboutUs, .aboutReading, .help, .trip]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
        //test()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupData()
        sideMenuController?.isRightViewSwipeGestureEnabled = true
    }
}
extension MenuViewController {
    func setupView(){
        tableView.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        isloggedIn = false
    }
    func localized(){}
    func setupData(){
        //tableView.isSelfSize = true
        self.tableView.generalRowHeight = 60.0
        if UserProfile.shared.isUserLogin() {
            for item in self.loginArr {
                tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: item, rowHeight: nil))
            }
            return
        }
        
        for item in self.notLoginArr {
            tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: item, rowHeight: nil))
        }

        self.tableView.reloadData()
    }
    func fetchData(){}
}





