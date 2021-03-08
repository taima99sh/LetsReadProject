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
    
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getMessages()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnSideMenu(_ sender: Any) {
        self.toggleRightViewAnimated(self)
    }
    
    @IBAction func btnSend(_ sender: Any) {
    }
}
extension MessagesListViewController {
    func setupView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    func getMessages() {
        let request = BaseRequest()
        let stId = UserProfile.shared.userID ?? 0
        request.url = "messages?st_id=\(stId)"
        request.method = .get
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            let data = MessageModels.init(fromJson: json)
            if data.success {
                if let messages = data.messages {
                    self.messages = messages
                    self.tableView.reloadData()
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
}

extension MessagesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesListTableViewCell") as! MessagesListTableViewCell
        cell.object = messages[indexPath.row]
        cell.configureCell()
        return cell
    }
}
