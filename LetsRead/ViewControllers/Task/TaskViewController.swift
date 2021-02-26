//
//  TaskViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVFoundation

class TaskViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var Taskid: String = ""
    
    var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        play()
        getPDF()
        localized()
        setupData()
        fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension TaskViewController {
    
    func getPDF(){
        let url = URL(string: "http://clients.intertech.ps/yallaneqra/public/files/stories/pdfs/story_305/103020-whose-voice-is-this.pdf")
        FileDownloader.loadFileAsync(url: url!) { (path, error) in
            print("PDF File downloaded to : \(path)")
            DispatchQueue.main.async {
                let fileURL = Bundle.main.url(forResource: "103020-whose-voice-is-this", withExtension: "pdf")!
                if let pdfViewController = PDFViewController(fileURL: fileURL, hasCoverPage: false) {
                    //self.addChild(pdfViewController)
                   self.addChild(pdfViewController)
                    pdfViewController.view.backgroundColor = .white
                   pdfViewController.view.frame = self.containerView.bounds
                   self.containerView.addSubview(pdfViewController.view)
                }
            }
        }
    }
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "YourAppName-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
                self.ErrorMessage(title: "", errorbody: "file does not exist")
            }
        }
    }
    func localized(){}
    func setupData(){}
    func fetchData(){}
    
    func play() {
        
        if let audioUrl = URL(string: "http://clients.intertech.ps/yallaneqra/public/files/audios/1595679044-1.mp3") {
            
            FileDownloader.loadFileAsync(url: audioUrl) { (url, error) in
                DispatchQueue.main.async {
                    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
                    print("playing")
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: destinationUrl)
                        print("")
                    } catch {
                        
                        print(error)
                    }

                }
         }   
    }
}
    func playinAudio() {
        
    }
}
