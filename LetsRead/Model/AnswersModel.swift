//
//  AnswersModel.swift
//  LetsRead
//
//  Created by taima on 3/3/21.
//  Copyright © 2021 mac air. All rights reserved.
//


import Foundation
import SwiftyJSON


class AnswersModel : NSObject, NSCoding{

    var success : Bool!
    var answers : [Question]!
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
        answers = [Question]()
        let answersArray = json["answers"].arrayValue
        for answersJson in answersArray{
            let value = Question(fromJson: answersJson)
            answers.append(value)
        }
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
        if answers != nil{
            var dictionaryElements = [[String:Any]]()
            for answersElement in answers {
                dictionaryElements.append(answersElement.toDictionary())
            }
            dictionary["answers"] = dictionaryElements
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
         answers = aDecoder.decodeObject(forKey: "answers") as? [Question]
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
        if answers != nil{
            aCoder.encode(answers, forKey: "answers")
        }
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }

    }

}

