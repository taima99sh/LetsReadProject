//
//  RecordingAudioViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingAudioViewController: UIViewController {
    //@IBOutlet weak var recordingButton: UIButton!
    
    var recordButton: UIButton!
    var stackView: UIStackView!
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    var whistlePlayer: AVAudioPlayer!
    var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        playingAudio()
        
        title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)

        title = "تسجيل"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)

        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }

    func loadRecordingUI() {
        recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        stackView.addArrangedSubview(recordButton)
        
        playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Tap to Play", for: .normal)
        playButton.isHidden = true
        playButton.alpha = 0
        playButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        stackView.addArrangedSubview(playButton)
    }

    func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0

        stackView.addArrangedSubview(failLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension RecordingAudioViewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
    
    @objc func addWhistle() {
        let vc = RecordingAudioViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadView() {
        view = UIView()

        view.backgroundColor = UIColor.gray

        stackView = UIStackView()
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getWhistleURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
    
    
    func startRecording() {
        // 1
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)

        // 2
        recordButton.setTitle("Tap to Stop", for: .normal)
        // 3
        let audioURL = RecordingAudioViewController.getWhistleURL()
        print(audioURL.absoluteString)
        // 4
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            // 5
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
        if playButton.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.playButton.isHidden = false
                self.playButton.alpha = 1
            }
        }

        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)

        whistleRecorder.stop()
        whistleRecorder = nil

        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)

            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func nextTapped() {
    }
    
    @objc func playTapped() {
        let audioURL = RecordingAudioViewController.getWhistleURL()

        do {
            whistlePlayer = try AVAudioPlayer(contentsOf: audioURL)
            whistlePlayer.play()
        } catch {
            let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func recordTapped() {
        
        if !playButton.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.playButton.isHidden = true
                self.playButton.alpha = 0
            }
        }
        if whistleRecorder == nil {
            startRecording()
            if !playButton.isHidden {
                UIView.animate(withDuration: 0.35) { [unowned self] in
                    self.playButton.isHidden = true
                    self.playButton.alpha = 0
                }
            }
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func playingAudio() {
        let fileURL = Bundle.main.url(forResource: "1595679044-1", withExtension: "mp3")!
       //let audioURL = RecordingAudioViewController.getWhistleURL()
        do {
            let whistlePlayer = try AVAudioPlayer(contentsOf: fileURL)
            whistlePlayer.play()
            
        }
        catch {
            print(error)
        }
       
    }
}


