//
//  SendMessageViewControlller.swift
//  LetsRead
//
//  Created by taima on 3/1/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class SendMessageViewControlller: UIViewController {
    
    @IBOutlet weak var txtMessage: UITextView!

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
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSend(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension SendMessageViewControlller {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
