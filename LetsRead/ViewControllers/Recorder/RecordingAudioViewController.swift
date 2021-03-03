//
//  RecordingAudioViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class RecordingAudioViewController: UIViewController {
    
    @IBOutlet weak var btnRecording: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var lblOverallDuration: UILabel!
    //@IBOutlet weak var lblcurrentText: UILabel!
    
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    var whistlePlayer: AVAudioPlayer!
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupData()
        playerView.isHidden = true
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Allowed")
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } catch {
            print(error)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func btnPlay(_ sender: Any) {
        self.playTapped()
        //convert()
        print("play Button")
    }
    
    @IBAction func btnSend(_ sender: Any) {
        sendRecord()
    }
        
    @IBAction func btnRecord(_ sender: Any) {
        self.recordTapped()
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.player?.rate = 0.0
        self.dismiss(animated: true, completion: nil)
    }
}
extension RecordingAudioViewController {
    func setupView(){
        
        
        
    }
    func localized(){}
    func setupData(_ url: URL) {
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playbackSlider.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:)), for: .valueChanged)
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        lblOverallDuration.text = self.stringFromTimeInterval(interval: seconds)
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        
        
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playbackSlider.value = Float ( time );
            }
            
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")

            } else {
                print("Buffering completed")

            }
            
        }
    }
    func fetchData(){}
    
    @objc func addWhistle() {
        let vc = RecordingAudioViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getWhistleURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("record.m4a")
    }
    
    func startRecording() {

        btnRecording.setTitle("إيقاف", for: .normal)
        let audioURL = RecordingAudioViewController.getWhistleURL()
        print(audioURL.absoluteString)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            whistleRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            whistleRecorder.delegate = self
            whistleRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
}

extension RecordingAudioViewController: AVAudioRecorderDelegate {
    
    func finishRecording(success: Bool) {
        if playerView.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.playerView.isHidden = false
                //self.playButton.alpha = 1
            }
        }
        
        whistleRecorder.stop()
        whistleRecorder = nil

        if success {
            btnRecording.setTitle("إعادة التسجيل", for: .normal)
        } else {
            btnRecording.setTitle("تسجيل", for: .normal)
        }
    }
    
    @objc func playTapped() {
        let audioURL = RecordingAudioViewController.getWhistleURL()
        do {
            setupData(audioURL)
            if player?.rate == 0
            {
                player!.play()
                //self.ButtonPlay.isHidden = true
                //self.loadingView.isHidden = false
                btnPlay.setImage(UIImage(systemName: "playpause.fill"), for: UIControl.State.normal)
            } else {
                player!.pause()
                btnPlay.setImage(UIImage(named: "play.fill"), for: UIControl.State.normal)
            }
//            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
//            audioPlayer?.play()
        } catch {
            self.ErrorMessage(title: "", errorbody: "Playback failed")
        }
        
    }
    
    @objc func recordTapped() {
        
        if !playerView.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.playerView.isHidden = true
            }
        }
        if whistleRecorder == nil {
            startRecording()
            if !playerView.isHidden {
                UIView.animate(withDuration: 0.35) { [unowned self] in
                    self.playerView.isHidden = true
                }
            }
        } else {
            finishRecording(success: true)
        }
    }
    
    func sendRecord() {
        
        let stID = UserProfile.shared.userID ?? 0
        var dic: [String: Any] = [
            "st_id": "\(stID)" ,
            "story_id": "317",
            "task_id" : "1733"
        ]
        let request = BaseRequest()
        request.url = "uploadSound"
        request.method = .post
        let file = BaseFile()
        file.name = "audio_blob"
        file.type = .audio
        guard let audioURL = convert() else {return}
        if let audioFile: Data = try? Data (contentsOf: audioURL) {
            print("")
            //dic["audio_blob"] = audioFile
            request.parameters = dic
            file.data = audioFile
            request.files.append(file)
        }
        
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            let data = GeneralResponse.init(fromJson: json)
            if data.success {
                self.SuccessMessage(title: "", successbody: data.message ?? "نجاح")
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message ?? "فشل")
            print("")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    // SLIDER FUNCTION

    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    //
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func convert() -> URL?{
        let audioURL = RecordingAudioViewController.getWhistleURL()
        let inputPath = audioURL.path
        if let outputURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("output.mp3") {
            let outputPath = outputURL.path
            print("Input Path: \(inputPath )")
            print("Output Path: \(outputPath )")

            let converter = ExtAudioConverter()
            converter.inputFilePath = inputPath
            converter.outputFilePath = outputPath
            converter.outputFormatID = kAudioFormatMPEGLayer3
            if converter.convert() {
                print("Done")
            }
            return outputURL
        }
            return nil
    }
    
    

    
    
}


