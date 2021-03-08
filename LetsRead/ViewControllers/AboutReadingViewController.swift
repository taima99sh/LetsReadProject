//
//  AboutReadingViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class AboutReadingViewController: UIViewController {
    
    @IBOutlet weak var txtView: UITextView!
    
    var id: String = "68527"

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
    
    @IBAction func btnSideMenu(_ sender: Any) {
        self.toggleRightViewAnimated(self)
    }
}
extension AboutReadingViewController {
    func setupView(){
    }
    func localized(){}
    func setupData(){}
    func fetchData(){

        let request = BaseRequest()
        request.url = "PageDetails/\(self.id)"
        request.method = .get
        self.showIndicator()
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            self.hideIndicator()
            let data = htmlPagesModel.init(fromJson: json)
            if data.success {
                if let page = data.pages {
                    self.txtView.text = page.pBody.html2Attributed?.string ?? ""
                    self.title = page.pTitle ?? ""
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
}
