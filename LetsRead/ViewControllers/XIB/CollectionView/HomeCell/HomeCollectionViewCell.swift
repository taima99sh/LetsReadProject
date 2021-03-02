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
        // Initialization code
    }
    
    @IBAction func btnListen(_ sender: Any) {
        if let obj = object {
            if let parent = self.parentViewController as? HomeViewController {
                let videoURLString = obj.storyListen ?? ""
                let urlString = videoURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = URL(string: urlString) {
                    let player = AVPlayer(url: url)
                      let playerViewController = AVPlayerViewController()
                      playerViewController.player = player
                    
                    parent.present(playerViewController, animated: true) {
                        player.play()
                      }
                }

            }
        }
        
    }
    
    @IBAction func btnRead(_ sender: Any) {
        if let obj = object {
            if let parent = self.parentViewController as? HomeViewController {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                vc.task = obj
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func btnQuestions(_ sender: Any) {
        if let obj = object {
            if let parent = self.parentViewController as? HomeViewController {
                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController
                vc.storyId = "\(obj.tsStory ?? 0)"
                vc.taskId = "\(obj.tsId ?? 0)"
                vc.questionArr = obj.questions ?? []
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
