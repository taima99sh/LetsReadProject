//
//  QuestionsViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVKit
class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtAnswer: UITextView!
    @IBOutlet weak var txtStackView: UIStackView!
    @IBOutlet weak var btnSpeaker: UIButton!
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSaveTextAnswer: UIButton!
    
    var isAnswered: Bool = false
    var audioPlayer: AVAudioPlayer?
    var arrIndex: Int = 0
    var choicesArr: [String] = []
    var questionArr: [Question] = []
    var answersDic: [String: String] = [:]
    var storyId: String = ""
    var taskId: String = ""
    var urlAudio: String = ""
    
    var isBtnSelect: Bool = true {
        didSet {
            if !isBtnSelect {
                self.btnSpeaker.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
                self.audioPlayer?.stop()
                return
            }
            self.btnSpeaker.setImage(UIImage(systemName: "speaker.2.fill"), for: .normal)
            play(urlAudio)
            //self.audioPlayer?.play()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.audioPlayer?.play()
        self.answersDic.removeAll()
    }
    
    @IBAction func btnSpeaker(_ sender: Any) {
        isBtnSelect = !isBtnSelect
    }
    
    @IBAction func btnNext(_ sender: Any) {
        guard !(arrIndex == self.questionArr.count) else {return}
        self.arrIndex += 1
        self.audioPlayer?.stop()
        self.getQuestion(self.arrIndex)
    }
    
    @IBAction func btnPre(_ sender: Any) {
        self.arrIndex -= 1
        self.audioPlayer?.stop()
        self.getQuestion(self.arrIndex)
    }
    
    @IBAction func btnSaveTextAnswer(_ sender: Any) {
        guard !(arrIndex == self.questionArr.count) else {return}
        self.addToAnswersDic(self.questionArr[self.arrIndex].qaId ?? 0, self.txtAnswer.text ?? "")
        self.arrIndex += 1
        self.audioPlayer?.stop()
        self.txtAnswer.text = ""
        self.getQuestion(self.arrIndex)
    }
}
extension QuestionsViewController {
    func setupView(){
        self.btnPre.isHidden = true
        self.btnNext.isHidden = true
        checkIfAnswered()
        self.isBtnSelect = true
        //collectionView.isHidden = true
        txtStackView.isHidden = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func getQuestion(_ index: Int){
        if self.arrIndex < questionArr.count {
            self.btnNext.isHidden = questionArr.count == 1 ? true : false
            self.btnPre.isHidden = arrIndex == 0 ? true : false
            //self.btnNext.setTitle(arrIndex == questionArr.count - 1 ? "إرسال" : "", for: .normal)
            //self.btnNext.setImage(arrIndex == questionArr.count - 1 ? UIImage() : UIImage(systemName: "arrow.right"), for: .normal)
            self.btnNext.isHidden = arrIndex == questionArr.count - 1 ? true : false
            let question = self.questionArr[index]
            if question.qaType == "Multiple" || question.qaType == "0"   {
                self.lblTitle.text = question.qaQ ?? ""
                self.collectionView.isHidden = false
                self.txtStackView.isHidden = true
                self.choicesArr.removeAll()
                self.urlAudio = question.audio ?? ""
                self.btnSpeaker.isHidden = question.audio.count == 0 ? true : false
                isBtnSelect = true
                //play(question.audio ?? "")
                appendToChoices(question.qaC1 ?? "")
                appendToChoices(question.qaC2 ?? "")
                appendToChoices(question.qaC3 ?? "")
                appendToChoices(question.qaC4 ?? "")
                self.collectionView.reloadData()
            } else {
                self.lblTitle.text = (question.qaText ?? "").html2Attributed?.string
                self.txtAnswer.text = (question.answerText ?? "").html2Attributed?.string
                self.collectionView.isHidden = true
                self.btnSpeaker.isHidden = question.audio.count == 0 ? true : false
                self.txtStackView.isHidden = false
                play(question.audio ?? "")
            }
            return
        }
        guard !self.isAnswered else {return}
        sendAnswers()
    }
    func sendAnswers(){
        guard !self.isAnswered else {return}
        guard answersDic.count == self.questionArr.count else {
            self.showErrorAlert(message: "هناك أسئلة غير مجاب عنها")
            return
        }
        let stId = UserProfile.shared.userID ?? 0
        var postParameters = "answerQuestions?st_id=\(stId)&story_id=\(storyId)&task_id=\(taskId)"
        for (key, value) in self.answersDic {
            postParameters += "&\(key)=\(value)"
        }
        print(postParameters)
        let request = BaseRequest()
        request.url = postParameters
        request.method = .get
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            let data = GeneralResponse.init(fromJson: json)
            if data.success {
                self.SuccessMessage(title: "", successbody: data.message)
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
            print("")
        }
    }
    
    func appendToChoices(_ choice: String) {
        guard choice.count != 0 else {return}
        self.choicesArr.append(choice)
    }
    
    func getAnswers() {
        let stId = UserProfile.shared.userID ?? 0
               let request = BaseRequest()
               request.url = "getAnswers?st_id=\(stId)&task_id=\(taskId)"
               request.method = .get
               RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
                   self.hideIndicator()
                   let data = AnswersModel.init(fromJson: json)
                if data.success && data.answers.count != 0 {
                       if let questions = data.answers {
                        self.questionArr = questions
                        self.getQuestion(self.arrIndex)
                       }
                       self.collectionView.reloadData()
                       return
                   }
                       self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
    
    func checkIfAnswered() {
               let stId = UserProfile.shared.userID ?? 0
               let request = BaseRequest()
               request.url = "checkAnswers?st_id=\(stId)&story_id=\(storyId)&task_id=\(taskId)"
               request.method = .get
               self.showIndicator()
               RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
                   let data = GeneralResponse.init(fromJson: json)
                if data.success && data.found  {
                    self.SuccessMessage(title: "", successbody: "قمت بحل هذه الأسئلة سابقاً")
                      self.isAnswered = data.found
                    self.txtAnswer.isEditable = false
                    self.btnSaveTextAnswer.isHidden = true
                    self.getAnswers()
                       self.collectionView.reloadData()
                       return
                   }
                self.hideIndicator()
                self.getQuestion(self.arrIndex)
                       //self.ErrorMessage(title: "", errorbody: data.message)
        }
    }
    
    func play(_ url: String) {
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let audioUrl = URL(string: urlString) {
            FileDownloader.loadFileAsync(url: audioUrl) { (url, error) in
                   DispatchQueue.main.async {
                       let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                       let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
                       print("playing")
                       do {
                           self.audioPlayer = try AVAudioPlayer(contentsOf: destinationUrl)
                           self.audioPlayer?.play()
                           print("")
                       } catch {

                           print(error)
                       }
                   }
            }
        }
    }
}

extension QuestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.choicesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCell", for: indexPath) as! QuestionsCollectionViewCell
        cell.object = self.choicesArr[indexPath.row]
        if self.isAnswered {
            if indexPath.row + 1 == self.questionArr[self.arrIndex].answerCh  {
                //cell.colorView.backgroundColor = .green
                if indexPath.row + 1  == self.questionArr[self.arrIndex].qaC  {
                    cell.colorView.backgroundColor = .green
                } else {
                    cell.colorView.backgroundColor = .red
                }
            } else {
                cell.colorView.backgroundColor = "primaryColor".myColor
            }
        }
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.isAnswered ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !(arrIndex == self.questionArr.count) else {return}
        self.addToAnswersDic(self.questionArr[self.arrIndex].qaId ?? 0, "\(indexPath.row + 1)")
        self.arrIndex += 1
        self.audioPlayer?.stop()
        self.getQuestion(self.arrIndex)
    }
}

extension QuestionsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let height: CGFloat = 165
            return CGSize.init(width: 80, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)

        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}

extension QuestionsViewController {
    func addToAnswersDic(_ qID: Int, _ answer: String) {
        self.answersDic["q\(qID)_ans"] = answer
    }
}



