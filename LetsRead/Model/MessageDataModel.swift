//
//  MessageDataModel.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation
import SwiftyJSON


class MessageModels : NSObject, NSCoding{

    var success : Bool!
    var code : Int!
    var message : String!
    var messages : [Message]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        success = json["Success"].boolValue
        code = json["code"].intValue
        message = json["message"].stringValue
        messages = [Message]()
        let messagesArray = json["messages"].arrayValue
        for messagesJson in messagesArray{
            let value = Message(fromJson: messagesJson)
            messages.append(value)
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
        if message != nil{
            dictionary["message"] = message
        }
        if messages != nil{
            var dictionaryElements = [[String:Any]]()
            for messagesElement in messages {
                dictionaryElements.append(messagesElement.toDictionary())
            }
            dictionary["messages"] = dictionaryElements
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
         message = aDecoder.decodeObject(forKey: "message") as? String
         messages = aDecoder.decodeObject(forKey: "messages") as? [Message]

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
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if messages != nil{
            aCoder.encode(messages, forKey: "messages")
        }

    }

}

class Message : NSObject, NSCoding{

    var body : String!
    var createdAt : String!
    var deleted : Int!
    var file : String!
    var id : Int!
    var receiverId : Int!
    var receiverType : Int!
    var seen : Int!
    var senderId : Int!
    var senderName : String!
    var senderType : Int!
    var title : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        body = json["body"].stringValue
        createdAt = json["created_at"].stringValue
        deleted = json["deleted"].intValue
        file = json["file"].stringValue
        id = json["id"].intValue
        receiverId = json["receiver_id"].intValue
        receiverType = json["receiver_type"].intValue
        seen = json["seen"].intValue
        senderId = json["sender_id"].intValue
        senderName = json["sender_name"].stringValue
        senderType = json["sender_type"].intValue
        title = json["title"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if body != nil{
            dictionary["body"] = body
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if deleted != nil{
            dictionary["deleted"] = deleted
        }
        if file != nil{
            dictionary["file"] = file
        }
        if id != nil{
            dictionary["id"] = id
        }
        if receiverId != nil{
            dictionary["receiver_id"] = receiverId
        }
        if receiverType != nil{
            dictionary["receiver_type"] = receiverType
        }
        if seen != nil{
            dictionary["seen"] = seen
        }
        if senderId != nil{
            dictionary["sender_id"] = senderId
        }
        if senderName != nil{
            dictionary["sender_name"] = senderName
        }
        if senderType != nil{
            dictionary["sender_type"] = senderType
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         body = aDecoder.decodeObject(forKey: "body") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         deleted = aDecoder.decodeObject(forKey: "deleted") as? Int
         file = aDecoder.decodeObject(forKey: "file") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         receiverId = aDecoder.decodeObject(forKey: "receiver_id") as? Int
         receiverType = aDecoder.decodeObject(forKey: "receiver_type") as? Int
         seen = aDecoder.decodeObject(forKey: "seen") as? Int
         senderId = aDecoder.decodeObject(forKey: "sender_id") as? Int
         senderName = aDecoder.decodeObject(forKey: "sender_name") as? String
         senderType = aDecoder.decodeObject(forKey: "sender_type") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if body != nil{
            aCoder.encode(body, forKey: "body")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if deleted != nil{
            aCoder.encode(deleted, forKey: "deleted")
        }
        if file != nil{
            aCoder.encode(file, forKey: "file")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if receiverId != nil{
            aCoder.encode(receiverId, forKey: "receiver_id")
        }
        if receiverType != nil{
            aCoder.encode(receiverType, forKey: "receiver_type")
        }
        if seen != nil{
            aCoder.encode(seen, forKey: "seen")
        }
        if senderId != nil{
            aCoder.encode(senderId, forKey: "sender_id")
        }
        if senderName != nil{
            aCoder.encode(senderName, forKey: "sender_name")
        }
        if senderType != nil{
            aCoder.encode(senderType, forKey: "sender_type")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }

    }

}
