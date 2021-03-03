//
//  MessagesListViewController.swift
//  LetsRead
//
//  Created by taima on 3/3/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MessagesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!

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
    
    @IBAction func btnSend(_ sender: Any) {
        
    }
}
extension MessagesListViewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
