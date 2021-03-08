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
    
    enum typePage: String {
        case listen
        case read
        case questions
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnToRecording: UIButton!
    @IBOutlet weak var btnListen: UIButton!
    @IBOutlet weak var btnRead: UIButton!
    @IBOutlet weak var btnQuestions: UIButton!
    @IBOutlet weak var listenView: UIView!
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var questionView: UIView!
    
    var vc1: UINavigationController!
    var vc2: QuestionsViewController!
    var vc3: AVPlayerViewController!
    var task: Previou?
    var player: AVPlayer!
    var pdfViewController: PDFViewController?
    
    var type: typePage = .read

    override func viewDidLoad() {
        super.viewDidLoad()
        //getPDF()
        setupPlayer()
        validation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblTitle.text = "    \(task?.storyTitle ?? "untitled")    "
        setupData()
    }
    
    @IBAction func btnSideMenu(_ sender: Any) {
        self.toggleRightViewAnimated(self)
    }
        
    @IBAction func btnListen(_ sender: Any) {
        btnListen.isEnabled = false
        btnRead.isEnabled = true
        btnQuestions.isEnabled = true
        self.btnToRecording.isHidden = true
        for sView in self.containerView.subviews {
            sView.removeFromSuperview()
        }
        setupPlayer()
        player.play()
        vc3.view.frame = self.containerView.bounds
        self.containerView.addSubview(vc3.view)
        btnListen.isEnabled = false
        btnRead.isEnabled = true
        btnQuestions.isEnabled = true
        return
        
    }
    
    @IBAction func btnRead(_ sender: Any) {
        player.pause()
        vc2.audioPlayer?.stop()
        btnListen.isEnabled = true
        btnRead.isEnabled = false
        btnQuestions.isEnabled = true
        self.btnToRecording.isHidden = false
        self.getPDF()
            for sView in self.containerView.subviews {
                sView.removeFromSuperview()
            vc1.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc1.view)
        }
    }
    
    @IBAction func btnToRecording(_ sender: Any) {
    }
    
    @IBAction func btnQuestions(_ sender: Any) {
        player.pause()
        vc2.audioPlayer?.stop()
        btnListen.isEnabled = true
        btnRead.isEnabled = true
        btnQuestions.isEnabled = false
        self.btnToRecording.isHidden = true
        for sView in self.containerView.subviews {
            sView.removeFromSuperview()
        }
        vc2.view.frame = self.containerView.bounds
        self.containerView.addSubview(vc2.view)
        self.vc2.didMove(toParent: self)
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
                            self.pdfViewController = pdfViewController
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
    
    func setupData(){
        vc2 = (UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController)
        vc1 = UINavigationController()
        vc3 = AVPlayerViewController()
        vc2.questionArr = task?.questions ?? []
        vc2.storyId = "\(task?.tsStory ?? 0)"
        vc2.taskId = "\(task?.tsId ?? 0)"
        self.addChild(vc2)
        self.addChild(vc3)
        
        switch self.type {
        case .listen:
            self.btnListen(self)
        case .read:
            self.btnRead(self)
        case .questions:
            self.btnQuestions(self)
        }
    }
    
    func setupPlayer() {
        if let task = task {
            let videoURLString = task.storyListen ?? ""
            let urlString = videoURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let url = URL(string: urlString) {
                 player = AVPlayer(url: url)
                  vc3 = AVPlayerViewController()
                  vc3.player = player
            }
        }
    }
    
    func validation() {
        if let obj = task,
           let listen = obj.storyListen,
            let read = obj.storyPdf,
            let questions = obj.questions {
            self.listenView.isHidden = listen.count == 0 ? true : false
            self.readView.isHidden = read.count == 0 ? true : false
            self.questionView.isHidden = questions.count == 0 ? true : false
        }
    }
}
