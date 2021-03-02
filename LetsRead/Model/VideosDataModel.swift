//
//  VideosDataModel.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//



import Foundation
import SwiftyJSON


class VideoModel : NSObject, NSCoding{

    var success : Bool!
    var code : Int!
    var message : String!
    var videos : [Video]!


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
        videos = [Video]()
        let videosArray = json["videos"].arrayValue
        for videosJson in videosArray{
            let value = Video(fromJson: videosJson)
            videos.append(value)
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
        if videos != nil{
            var dictionaryElements = [[String:Any]]()
            for videosElement in videos {
                dictionaryElements.append(videosElement.toDictionary())
            }
            dictionary["videos"] = dictionaryElements
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
         videos = aDecoder.decodeObject(forKey: "videos") as? [Video]

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
        if videos != nil{
            aCoder.encode(videos, forKey: "videos")
        }

    }

}


class Video : NSObject, NSCoding{

    var videoHtml : String!
    var videoId : Int!
    var videoImg : String!
    var videoLevel : Int!
    var videoLink : String!
    var videoTitle : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        videoHtml = json["video_html"].stringValue
        videoId = json["video_id"].intValue
        videoImg = json["video_img"].stringValue
        videoLevel = json["video_level"].intValue
        videoLink = json["video_link"].stringValue
        videoTitle = json["video_title"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if videoHtml != nil{
            dictionary["video_html"] = videoHtml
        }
        if videoId != nil{
            dictionary["video_id"] = videoId
        }
        if videoImg != nil{
            dictionary["video_img"] = videoImg
        }
        if videoLevel != nil{
            dictionary["video_level"] = videoLevel
        }
        if videoLink != nil{
            dictionary["video_link"] = videoLink
        }
        if videoTitle != nil{
            dictionary["video_title"] = videoTitle
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         videoHtml = aDecoder.decodeObject(forKey: "video_html") as? String
         videoId = aDecoder.decodeObject(forKey: "video_id") as? Int
         videoImg = aDecoder.decodeObject(forKey: "video_img") as? String
         videoLevel = aDecoder.decodeObject(forKey: "video_level") as? Int
         videoLink = aDecoder.decodeObject(forKey: "video_link") as? String
         videoTitle = aDecoder.decodeObject(forKey: "video_title") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if videoHtml != nil{
            aCoder.encode(videoHtml, forKey: "video_html")
        }
        if videoId != nil{
            aCoder.encode(videoId, forKey: "video_id")
        }
        if videoImg != nil{
            aCoder.encode(videoImg, forKey: "video_img")
        }
        if videoLevel != nil{
            aCoder.encode(videoLevel, forKey: "video_level")
        }
        if videoLink != nil{
            aCoder.encode(videoLink, forKey: "video_link")
        }
        if videoTitle != nil{
            aCoder.encode(videoTitle, forKey: "video_title")
        }

    }

}
