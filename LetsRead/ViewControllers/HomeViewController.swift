//
//  HomeViewController.swift
//  Let's Read
//
//  Created by taima on 2/23/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import  LGSideMenuController

class HomeViewController: UIViewController {
    
    enum typePage: String {
        case pastTasks
        case newTasks
        case suggestedTasks
    }
    
    @IBOutlet weak var lineSuggested: UIView!
    @IBOutlet weak var lineNew: UIView!
    @IBOutlet weak var linePast: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnNewTasks: UIButton!
    @IBOutlet weak var btnPastTasks: UIButton!
    @IBOutlet weak var btnSuggestedTasks: UIButton!
    @IBOutlet weak var lblNewTasks: UILabel!
    @IBOutlet weak var lblSuggestedTasks: UILabel!
    @IBOutlet weak var lblPastTasks: UILabel!
    @IBOutlet weak var messagesView: UIView!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var lblPoints: UILabel!
    
    var collectionArr: [Previou] = []
    var currrent: [Previou] = []
    var previous: [Previou] = []
    var messages: [Message] = []
    var isMessagesButtonTapped: Bool = false {
        didSet {
            self.messagesView.isHidden = !isMessagesButtonTapped
        }
    }
    
    var isPointsButtonTapped: Bool = false {
        didSet {
            self.pointsView.isHidden = !isPointsButtonTapped
        }
    }
    var type: typePage = .pastTasks {
        didSet {
            updateGUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        
        if UserProfile.shared.isUserLogin() {
            fetchData()
            getPoints()
            getMessages()
        } else {
            self.getTripStories()
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnPastTasks(_ sender: Any) {
        self.type = .pastTasks
        self.collectionArr = previous
        self.collectionView.reloadData()
    }
    
    @IBAction func btnNewTasks(_ sender: Any) {
        self.type = .newTasks
         self.collectionArr = currrent
        self.collectionView.reloadData()
    }
    
    @IBAction func btnSuggestedTasks(_ sender: Any) {
        self.type = .suggestedTasks
    }
    
    @IBAction func btnStar(_ sender: Any) {
      self.isMessagesButtonTapped = !isMessagesButtonTapped
    }
    
    @IBAction func btnNewMessage(_ sender: Any) {
    }
    
    @IBAction func btnMessages(_ sender: Any) {
        isPointsButtonTapped = !isPointsButtonTapped
    }
}

extension HomeViewController {
    func setupView(){
        self.isMessagesButtonTapped = false
        isPointsButtonTapped = false
        self.type = .pastTasks
        self.navigationItem.leftItemsSupplementBackButton = true
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AboutReadingViewController") as! AboutReadingViewController
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
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
                    self.messagesTableView.reloadData()
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
    
    func getPoints() {
        let request = BaseRequest()
        let stId = UserProfile.shared.userID ?? 0
        request.url = "getBalance?st_id=\(stId)"
        request.method = .get
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            let data = GeneralResponse.init(fromJson: json)
            if data.success {
                if let balance = data.balance {
                    self.lblPoints.text = "\(balance)\nنقطة"
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
    
    func localized(){}
    func setupData(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.messagesTableView.delegate = self
        self.messagesTableView.dataSource = self
    }
    func fetchData(){
        let stId = UserProfile.shared.userID ?? 0
        
        let request = BaseRequest()
        request.url = "stories?st_id=\(stId)"
        request.method = .get
        self.showIndicator()
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            self.hideIndicator()
            let data = StoriesModel.init(fromJson: json)
            if data.success {
                if let previousStories = data.previous,
                    let currentStories = data.current {
                    self.collectionArr = previousStories
                    self.previous = previousStories
                    self.currrent = currentStories
                }
                self.collectionView.reloadData()
                return
            }
                self.ErrorMessage(title: "", errorbody: data.message)
            }
    }
    func getTripStories() {
        
               let request = BaseRequest()
               request.url = "tripStories"
               request.method = .get
               self.showIndicator()
               RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
                   self.hideIndicator()
                   let data = TripModel.init(fromJson: json)
                   if data.success {
                       if let stories = data.stories {
                        if let data = stories.data {
                            for obj in data {
                                self.collectionArr.append(Previou(obj))
                            }
                        }
                       }
                       self.collectionView.reloadData()
                       return
                   }
                       self.ErrorMessage(title: "", errorbody: data.message)
                   }
    }
    func updateGUI() {
        switch self.type {
        case .pastTasks:
            self.linePast.backgroundColor = "darkTxtColor".myColor
            self.lineNew.backgroundColor = "placeholderColor".myColor
            self.lineSuggested.backgroundColor = "placeholderColor".myColor
            self.lblPastTasks.textColor = "darkTxtColor".myColor
            self.lblNewTasks.textColor = "placeholderColor".myColor
            self.lblSuggestedTasks.textColor = "placeholderColor".myColor
        case .newTasks:
            self.lineNew.backgroundColor = "darkTxtColor".myColor
            self.linePast.backgroundColor = "placeholderColor".myColor
            self.lineSuggested.backgroundColor = "placeholderColor".myColor
            self.lblPastTasks.textColor = "placeholderColor".myColor
            self.lblNewTasks.textColor = "darkTxtColor".myColor
            self.lblSuggestedTasks.textColor = "placeholderColor".myColor
            
        case .suggestedTasks:
            self.lineNew.backgroundColor = "placeholderColor".myColor
            self.linePast.backgroundColor = "placeholderColor".myColor
            self.lineSuggested.backgroundColor = "darkTxtColor".myColor
            self.lblPastTasks.textColor = "placeholderColor".myColor
            self.lblNewTasks.textColor = "placeholderColor".myColor
            self.lblSuggestedTasks.textColor = "darkTxtColor".myColor
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 250
        let width: CGFloat = (UIScreen.main.bounds.size.width - ( 15 + 15 + 16 + 44 + 44)) / 2
            return CGSize.init(width: width, height: height)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.object = self.collectionArr[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.task = self.collectionArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getStories() {
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageTableViewCell
        cell.object = messages[indexPath.row]
        cell.configureCell()
        return cell
    }
}




