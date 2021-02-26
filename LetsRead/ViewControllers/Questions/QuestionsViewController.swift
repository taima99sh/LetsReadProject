//
//  QuestionsViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let QuestionArr: [String] = []
    var answersDic: [String: String] = [:]
    
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
extension QuestionsViewController {
    func setupView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func localized(){}
    func setupData(){}
    func fetchData(){}
}

extension QuestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCell", for: indexPath) as! QuestionsCollectionViewCell
        cell.object = self.QuestionArr[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.answersArr.append(self.QuestionArr[indexPath.row])
        
        if indexPath.row == self.QuestionArr.count - 1 {
            //send answers
        }
    }
}

extension QuestionsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let height: CGFloat = 165
            return CGSize.init(width: 60, height: 35)
    }
}

extension QuestionsViewController {
    func addToAnswersDic(_ qID: Int, _ answer: String) {
        self.answersDic["q\(qID)_ans"] = answer
    }
}


