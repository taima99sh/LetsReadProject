//
//  StoriesDataModel.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//


//
//    StoriesModel.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class StoriesModel : NSObject, NSCoding{

    var success : Bool!
    var code : Int!
    var current : [Previou]!
    var message : String!
    var previous : [Previou]!
    var suggested : [Previou]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        success = json["Success"].boolValue
        code = json["code"].intValue
        current = [Previou]()
        let currentArray = json["current"].arrayValue
        for currentJson in currentArray{
            let value = Previou(fromJson: currentJson)
            current.append(value)
        }
        message = json["message"].stringValue
        previous = [Previou]()
        let previousArray = json["previous"].arrayValue
        for previousJson in previousArray{
            let value = Previou(fromJson: previousJson)
            previous.append(value)
        }
        suggested = [Previou]()
        let suggestedArray = json["suggested"].arrayValue
        for suggestedJson in suggestedArray{
            let value = Previou(fromJson: suggestedJson)
            suggested.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if success != nil{
            dictionary["Success"] = success
        }
        if code != nil{
            dictionary["code"] = code
        }
        if current != nil{
            var dictionaryElements = [[String:Any]]()
            for currentElement in current {
                dictionaryElements.append(currentElement.toDictionary())
            }
            dictionary["current"] = dictionaryElements
        }
        if message != nil{
            dictionary["message"] = message
        }
        if previous != nil{
            var dictionaryElements = [[String:Any]]()
            for previousElement in previous {
                dictionaryElements.append(previousElement.toDictionary())
            }
            dictionary["previous"] = dictionaryElements
        }
        if suggested != nil{
            var dictionaryElements = [[String:Any]]()
            for suggestedElement in suggested {
                dictionaryElements.append(suggestedElement.toDictionary())
            }
            dictionary["suggested"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         success = aDecoder.decodeObject(forKey: "Success") as? Bool
         code = aDecoder.decodeObject(forKey: "code") as? Int
         current = aDecoder.decodeObject(forKey: "current") as? [Previou]
         message = aDecoder.decodeObject(forKey: "message") as? String
         previous = aDecoder.decodeObject(forKey: "previous") as? [Previou]
         suggested = aDecoder.decodeObject(forKey: "suggested") as? [Previou]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if success != nil{
            aCoder.encode(success, forKey: "Success")
        }
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if current != nil{
            aCoder.encode(current, forKey: "current")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if previous != nil{
            aCoder.encode(previous, forKey: "previous")
        }
        if suggested != nil{
            aCoder.encode(suggested, forKey: "suggested")
        }

    }

}


class Previou : NSObject, NSCoding{

    var isplayed : Bool!
    var questions : [Question]!
    var storyImg : String!
    var storyLang : Int!
    var storyListen : String!
    var storyPdf : String!
    var storyRead : String!
    var storyTitle : String!
    var tsFrom : String!
    var tsId : Int!
    var tsName : String!
    var tsStory : Int!
    var tsTo : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        isplayed = json["isplayed"].boolValue
        questions = [Question]()
        let questionsArray = json["questions"].arrayValue
        for questionsJson in questionsArray{
            let value = Question(fromJson: questionsJson)
            questions.append(value)
        }
        storyImg = json["story_img"].stringValue
        storyLang = json["story_lang"].intValue
        storyListen = json["story_listen"].stringValue
        storyPdf = json["story_pdf"].stringValue
        storyRead = json["story_read"].stringValue
        storyTitle = json["story_title"].stringValue
        tsFrom = json["ts_from"].stringValue
        tsId = json["ts_id"].intValue
        tsName = json["ts_name"].stringValue
        tsStory = json["ts_story"].intValue
        tsTo = json["ts_to"].stringValue
    }
    
    
    init(_ obj : TripStory){
        self.tsId = obj.storyId
        self.storyTitle = obj.storyTitle
        self.storyImg = obj.storyImg
        self.storyListen = obj.storyHtml
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isplayed != nil{
            dictionary["isplayed"] = isplayed
        }
        if questions != nil{
            var dictionaryElements = [[String:Any]]()
            for questionsElement in questions {
                dictionaryElements.append(questionsElement.toDictionary())
            }
            dictionary["questions"] = dictionaryElements
        }
        if storyImg != nil{
            dictionary["story_img"] = storyImg
        }
        if storyLang != nil{
            dictionary["story_lang"] = storyLang
        }
        if storyListen != nil{
            dictionary["story_listen"] = storyListen
        }
        if storyPdf != nil{
            dictionary["story_pdf"] = storyPdf
        }
        if storyRead != nil{
            dictionary["story_read"] = storyRead
        }
        if storyTitle != nil{
            dictionary["story_title"] = storyTitle
        }
        if tsFrom != nil{
            dictionary["ts_from"] = tsFrom
        }
        if tsId != nil{
            dictionary["ts_id"] = tsId
        }
        if tsName != nil{
            dictionary["ts_name"] = tsName
        }
        if tsStory != nil{
            dictionary["ts_story"] = tsStory
        }
        if tsTo != nil{
            dictionary["ts_to"] = tsTo
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         isplayed = aDecoder.decodeObject(forKey: "isplayed") as? Bool
         questions = aDecoder.decodeObject(forKey: "questions") as? [Question]
         storyImg = aDecoder.decodeObject(forKey: "story_img") as? String
         storyLang = aDecoder.decodeObject(forKey: "story_lang") as? Int
         storyListen = aDecoder.decodeObject(forKey: "story_listen") as? String
         storyPdf = aDecoder.decodeObject(forKey: "story_pdf") as? String
         storyRead = aDecoder.decodeObject(forKey: "story_read") as? String
         storyTitle = aDecoder.decodeObject(forKey: "story_title") as? String
         tsFrom = aDecoder.decodeObject(forKey: "ts_from") as? String
         tsId = aDecoder.decodeObject(forKey: "ts_id") as? Int
         tsName = aDecoder.decodeObject(forKey: "ts_name") as? String
         tsStory = aDecoder.decodeObject(forKey: "ts_story") as? Int
         tsTo = aDecoder.decodeObject(forKey: "ts_to") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if isplayed != nil{
            aCoder.encode(isplayed, forKey: "isplayed")
        }
        if questions != nil{
            aCoder.encode(questions, forKey: "questions")
        }
        if storyImg != nil{
            aCoder.encode(storyImg, forKey: "story_img")
        }
        if storyLang != nil{
            aCoder.encode(storyLang, forKey: "story_lang")
        }
        if storyListen != nil{
            aCoder.encode(storyListen, forKey: "story_listen")
        }
        if storyPdf != nil{
            aCoder.encode(storyPdf, forKey: "story_pdf")
        }
        if storyRead != nil{
            aCoder.encode(storyRead, forKey: "story_read")
        }
        if storyTitle != nil{
            aCoder.encode(storyTitle, forKey: "story_title")
        }
        if tsFrom != nil{
            aCoder.encode(tsFrom, forKey: "ts_from")
        }
        if tsId != nil{
            aCoder.encode(tsId, forKey: "ts_id")
        }
        if tsName != nil{
            aCoder.encode(tsName, forKey: "ts_name")
        }
        if tsStory != nil{
            aCoder.encode(tsStory, forKey: "ts_story")
        }
        if tsTo != nil{
            aCoder.encode(tsTo, forKey: "ts_to")
        }

    }

}


class Question : NSObject, NSCoding{

    var audio : String!
    var priority : Int!
    var qaC : Int!
    var qaC1 : String!
    var qaC2 : String!
    var qaC3 : String!
    var qaC4 : String!
    var qaId : Int!
    var qaQ : String!
    var qaStory : Int!
    var qaText : String!
    var qaType : String!
    var answerCh : Int!
    var answerText : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        answerCh = json["answer_ch"].intValue
        answerText = json["answer_text"].stringValue
        audio = json["audio"].stringValue
        priority = json["priority"].intValue
        qaC = json["qa_c"].intValue
        qaC1 = json["qa_c1"].stringValue
        qaC2 = json["qa_c2"].stringValue
        qaC3 = json["qa_c3"].stringValue
        qaC4 = json["qa_c4"].stringValue
        qaId = json["qa_id"].intValue
        qaQ = json["qa_q"].stringValue
        qaStory = json["qa_story"].intValue
        qaText = json["qa_text"].stringValue
        qaType = json["qa_type"].stringValue
    }
    
   // init(from obj: Answer)

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if answerCh != nil{
            dictionary["answer_ch"] = answerCh
        }
        if answerText != nil{
            dictionary["answer_text"] = answerText
        }
        if audio != nil{
            dictionary["audio"] = audio
        }
        if priority != nil{
            dictionary["priority"] = priority
        }
        if qaC != nil{
            dictionary["qa_c"] = qaC
        }
        if qaC1 != nil{
            dictionary["qa_c1"] = qaC1
        }
        if qaC2 != nil{
            dictionary["qa_c2"] = qaC2
        }
        if qaC3 != nil{
            dictionary["qa_c3"] = qaC3
        }
        if qaC4 != nil{
            dictionary["qa_c4"] = qaC4
        }
        if qaId != nil{
            dictionary["qa_id"] = qaId
        }
        if qaQ != nil{
            dictionary["qa_q"] = qaQ
        }
        if qaStory != nil{
            dictionary["qa_story"] = qaStory
        }
        if qaText != nil{
            dictionary["qa_text"] = qaText
        }
        if qaType != nil{
            dictionary["qa_type"] = qaType
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        
        answerCh = aDecoder.decodeObject(forKey: "answer_ch") as? Int
        answerText = aDecoder.decodeObject(forKey: "answer_text") as? String
         audio = aDecoder.decodeObject(forKey: "audio") as? String
         priority = aDecoder.decodeObject(forKey: "priority") as? Int
         qaC = aDecoder.decodeObject(forKey: "qa_c") as? Int
         qaC1 = aDecoder.decodeObject(forKey: "qa_c1") as? String
         qaC2 = aDecoder.decodeObject(forKey: "qa_c2") as? String
         qaC3 = aDecoder.decodeObject(forKey: "qa_c3") as? String
         qaC4 = aDecoder.decodeObject(forKey: "qa_c4") as? String
         qaId = aDecoder.decodeObject(forKey: "qa_id") as? Int
         qaQ = aDecoder.decodeObject(forKey: "qa_q") as? String
         qaStory = aDecoder.decodeObject(forKey: "qa_story") as? Int
         qaText = aDecoder.decodeObject(forKey: "qa_text") as? String
         qaType = aDecoder.decodeObject(forKey: "qa_type") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if answerCh != nil{
            aCoder.encode(answerCh, forKey: "answer_ch")
        }
        if answerText != nil{
            aCoder.encode(answerText, forKey: "answer_text")
        }
        if audio != nil{
            aCoder.encode(audio, forKey: "audio")
        }
        if priority != nil{
            aCoder.encode(priority, forKey: "priority")
        }
        if qaC != nil{
            aCoder.encode(qaC, forKey: "qa_c")
        }
        if qaC1 != nil{
            aCoder.encode(qaC1, forKey: "qa_c1")
        }
        if qaC2 != nil{
            aCoder.encode(qaC2, forKey: "qa_c2")
        }
        if qaC3 != nil{
            aCoder.encode(qaC3, forKey: "qa_c3")
        }
        if qaC4 != nil{
            aCoder.encode(qaC4, forKey: "qa_c4")
        }
        if qaId != nil{
            aCoder.encode(qaId, forKey: "qa_id")
        }
        if qaQ != nil{
            aCoder.encode(qaQ, forKey: "qa_q")
        }
        if qaStory != nil{
            aCoder.encode(qaStory, forKey: "qa_story")
        }
        if qaText != nil{
            aCoder.encode(qaText, forKey: "qa_text")
        }
        if qaType != nil{
            aCoder.encode(qaType, forKey: "qa_type")
        }

    }

}



class GeneralResponse : NSObject, NSCoding{

    var success : Bool!
    var found : Bool!
    var balance : Int!
    var code : Int!
    var message : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        success = json["Success"].boolValue
        found = json["Found"].boolValue
        balance = json["balance"].intValue
        code = json["code"].intValue
        message = json["message"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if success != nil{
            dictionary["Success"] = success
        }
        
        if found != nil{
            dictionary["Success"] = success
        }
        if balance != nil{
            dictionary["balance"] = balance
        }
        if code != nil{
            dictionary["code"] = code
        }
        if message != nil{
            dictionary["message"] = message
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         success = aDecoder.decodeObject(forKey: "Success") as? Bool
         found = aDecoder.decodeObject(forKey: "Found") as? Bool
         balance = aDecoder.decodeObject(forKey: "balance") as? Int
         code = aDecoder.decodeObject(forKey: "code") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if success != nil{
            aCoder.encode(success, forKey: "Success")
        }
        if found != nil{
            aCoder.encode(success, forKey: "Found")
        }
        if balance != nil{
            aCoder.encode(balance, forKey: "balance")
        }
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }

    }

}



class htmlPagesModel : NSObject, NSCoding{

    var pages : Page!
    var success : Bool!
    var code : Int!
    var message : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let pagesJson = json["Pages"]
        if !pagesJson.isEmpty{
            pages = Page(fromJson: pagesJson)
        }
        success = json["Success"].boolValue
        code = json["code"].intValue
        message = json["message"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if pages != nil{
            dictionary["Pages"] = pages.toDictionary()
        }
        if success != nil{
            dictionary["Success"] = success
        }
        if code != nil{
            dictionary["code"] = code
        }
        if message != nil{
            dictionary["message"] = message
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         pages = aDecoder.decodeObject(forKey: "Pages") as? Page
         success = aDecoder.decodeObject(forKey: "Success") as? Bool
         code = aDecoder.decodeObject(forKey: "code") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if pages != nil{
            aCoder.encode(pages, forKey: "Pages")
        }
        if success != nil{
            aCoder.encode(success, forKey: "Success")
        }
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }

    }

}


class Page : NSObject, NSCoding{

    var pBody : String!
    var pId : Int!
    var pSummary : AnyObject!
    var pThumb : String!
    var pThumb2 : String!
    var pTitle : String!
    var pUrl : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        pBody = json["p_body"].stringValue
        pId = json["p_id"].intValue
        pSummary = json["p_summary"].stringValue as AnyObject
        pThumb = json["p_thumb"].stringValue
        pThumb2 = json["p_thumb2"].stringValue
        pTitle = json["p_title"].stringValue
        pUrl = json["p_url"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if pBody != nil{
            dictionary["p_body"] = pBody
        }
        if pId != nil{
            dictionary["p_id"] = pId
        }
        if pSummary != nil{
            dictionary["p_summary"] = pSummary
        }
        if pThumb != nil{
            dictionary["p_thumb"] = pThumb
        }
        if pThumb2 != nil{
            dictionary["p_thumb2"] = pThumb2
        }
        if pTitle != nil{
            dictionary["p_title"] = pTitle
        }
        if pUrl != nil{
            dictionary["p_url"] = pUrl
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         pBody = aDecoder.decodeObject(forKey: "p_body") as? String
         pId = aDecoder.decodeObject(forKey: "p_id") as? Int
         pSummary = aDecoder.decodeObject(forKey: "p_summary") as? AnyObject
         pThumb = aDecoder.decodeObject(forKey: "p_thumb") as? String
         pThumb2 = aDecoder.decodeObject(forKey: "p_thumb2") as? String
         pTitle = aDecoder.decodeObject(forKey: "p_title") as? String
         pUrl = aDecoder.decodeObject(forKey: "p_url") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if pBody != nil{
            aCoder.encode(pBody, forKey: "p_body")
        }
        if pId != nil{
            aCoder.encode(pId, forKey: "p_id")
        }
        if pSummary != nil{
            aCoder.encode(pSummary, forKey: "p_summary")
        }
        if pThumb != nil{
            aCoder.encode(pThumb, forKey: "p_thumb")
        }
        if pThumb2 != nil{
            aCoder.encode(pThumb2, forKey: "p_thumb2")
        }
        if pTitle != nil{
            aCoder.encode(pTitle, forKey: "p_title")
        }
        if pUrl != nil{
            aCoder.encode(pUrl, forKey: "p_url")
        }

    }

}
