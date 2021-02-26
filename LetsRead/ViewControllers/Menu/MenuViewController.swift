//
//  MenuViewController.swift
//  LetsRead
//
//  Created by taima on 2/24/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import LGSideMenuController

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: GeneralTableView!
    
    let loginArr: [Constant.MenuItems] = [.help, .test, .videos]
    let notLoginArr: [Constant.MenuItems] = [.messages, .library, .games]
    
    var isloggedIn: Bool = false 
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
        sideMenuController?.isRightViewSwipeGestureEnabled = true
        
    }
}
extension MenuViewController {
    func setupView(){
        tableView.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        self.isloggedIn = false
    }
    func localized(){}
    func setupData(){
        tableView.isSelfSize = true
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.library, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.test, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.videos, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.games, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.help, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.messages, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.aboutUs, rowHeight: nil))
        tableView.objects.append(GeneralTableViewData.init(identifier: "MenuTableViewCell", object: Constant.MenuItems.SignOut, rowHeight: nil))
    }
    func fetchData(){}
}





