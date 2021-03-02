//
//  TaskViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnToRecording: UIButton!

    var vc1: UINavigationController!
    var vc2: QuestionsViewController!
    var vc1Active : Bool = true
    var task: Previou?
    
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        //play()
        //setupData()
        getPDF()
        localized()
        fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblTitle.text = "    \(task?.storyTitle ?? "untitled")    "
        setupData()
    }
    
    @IBAction func btnListen(_ sender: Any) {
        if let task = task {
            let videoURLString = task.storyListen ?? ""
            let urlString = videoURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let url = URL(string: urlString) {
                let player = AVPlayer(url: url)
                  let playerViewController = AVPlayerViewController()
                  playerViewController.player = player
                
                self.present(playerViewController, animated: true) {
                    player.play()
                  }
            }
        }
    }
    
    @IBAction func btnRead(_ sender: Any) {
        self.btnToRecording.isHidden = false
        if !vc1Active  {
            for sView in self.containerView.subviews {
                sView.removeFromSuperview()
            }
            vc1Active = true
            vc1.view.frame = self.containerView.bounds
            //self.getPDF()
            self.containerView.addSubview(vc1.view)
        }
    }
    
    
    @IBAction func btnToRecording(_ sender: Any) {
    }
    
    @IBAction func btnQuestions(_ sender: Any) {
        self.btnToRecording.isHidden = true
        if vc1Active {
            for sView in self.containerView.subviews {
                sView.removeFromSuperview()
            }
        vc1Active = false
        vc2.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc2.view)
        }
    }
}

extension TaskViewController {
    func getPDF(){
        if let obj = self.task {
            let test = obj.storyPdf ?? ""
            let urlString = test.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let url = URL(string: urlString) {
                self.showIndicator()
                FileDownloader.loadFileAsync(url: url) { (path, error) in
                    print("PDF File downloaded to : \(String(describing: path))")
                    DispatchQueue.main.async {
                        self.hideIndicator()
                        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
                        if let pdfViewController = PDFViewController(fileURL: destinationUrl, hasCoverPage: false, lang: self.task?.storyLang ?? 0) {
                            //pdfViewController.lang
                            //vc1.setroo
                           let navigationController = UINavigationController(rootViewController: pdfViewController)
                            self.vc1.setViewControllers([pdfViewController], animated: true)
                            self.addChild(self.vc1)
                           self.vc1.view.frame = self.containerView.bounds
                           self.vc1.setNavigationBarHidden(true, animated: false)
                           self.containerView.addSubview(self.vc1.view)
                            self.vc1.didMove(toParent: self)
                        }
                    }
                }
            }
        }
   }    
    func localized(){}
    func setupData(){
        vc2 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController
        vc1 = UINavigationController()
        vc2.questionArr = task?.questions ?? []
        vc2.storyId = "\(task?.tsStory ?? 0)"
        vc2.taskId = "\(task?.tsId ?? 0)"
        self.addChild(vc2)
    }
    func fetchData(){}
    
    
}
