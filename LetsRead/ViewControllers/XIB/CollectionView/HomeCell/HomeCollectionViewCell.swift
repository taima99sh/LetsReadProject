//
//  HomeCollectionViewCell.swift
//  Let's Read
//
//  Created by taima on 2/23/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    var object: Previou?
    var questions: [String] = []
    var listen: String = ""
    var read: String = ""
    @IBOutlet weak var imgStory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var listenView: UIView!
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var questionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if !UserProfile.shared.isUserLogin() {
            listenView.isHidden = true
            readView.isHidden = true
            questionView.isHidden = true
        }
        // Initialization code
    }
    
    @IBAction func btnListen(_ sender: Any) {
        if let obj = object {
            if let parent = self.parentViewController as? HomeViewController {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                vc.task = obj
                vc.type = .listen
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    @IBAction func btnRead(_ sender: Any) {
        if let obj = object {
            if let parent = self.parentViewController as? HomeViewController {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                vc.task = obj
                vc.type = .read
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func btnQuestions(_ sender: Any) {
        
        if let obj = object {
            if let parent = self.parentViewController as? HomeViewController {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                vc.task = obj
                vc.type = .questions
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
        
    func configureCell() {
        self.validation()
        if let obj = self.object{
            let urlString = obj.storyImg.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            self.imgStory.LoadImageFromUrl(url: urlString ?? "")
            self.lblTitle.text = obj.storyTitle ?? "untitled"
        }
    }
    
    func validation() {
        if let obj = object,
           let listen = obj.storyListen,
            let read = obj.storyPdf,
            let questions = obj.questions {
            self.listenView.isHidden = listen.count == 0 ? true : false
            self.readView.isHidden = read.count == 0 ? true : false
            self.questionView.isHidden = questions.count == 0 ? true : false
        }
    }


}
