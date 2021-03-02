//
//  GameDataModel.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//


import Foundation
import SwiftyJSON


class GamesModel : NSObject, NSCoding{

    var success : Bool!
    var code : Int!
    var games : [Game]!
    var message : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        success = json["Success"].boolValue
        code = json["code"].intValue
        games = [Game]()
        let gamesArray = json["games"].arrayValue
        for gamesJson in gamesArray{
            let value = Game(fromJson: gamesJson)
            games.append(value)
        }
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
        if code != nil{
            dictionary["code"] = code
        }
        if games != nil{
            var dictionaryElements = [[String:Any]]()
            for gamesElement in games {
                dictionaryElements.append(gamesElement.toDictionary())
            }
            dictionary["games"] = dictionaryElements
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
         code = aDecoder.decodeObject(forKey: "code") as? Int
         games = aDecoder.decodeObject(forKey: "games") as? [Game]
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
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if games != nil{
            aCoder.encode(games, forKey: "games")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
    }
}



class Game : NSObject, NSCoding{

    var gameId : Int!
    var gameImg : String!
    var gameTitle : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        gameId = json["game_id"].intValue
        gameImg = json["game_img"].stringValue
        gameTitle = json["game_title"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if gameId != nil{
            dictionary["game_id"] = gameId
        }
        if gameImg != nil{
            dictionary["game_img"] = gameImg
        }
        if gameTitle != nil{
            dictionary["game_title"] = gameTitle
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         gameId = aDecoder.decodeObject(forKey: "game_id") as? Int
         gameImg = aDecoder.decodeObject(forKey: "game_img") as? String
         gameTitle = aDecoder.decodeObject(forKey: "game_title") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if gameId != nil{
            aCoder.encode(gameId, forKey: "game_id")
        }
        if gameImg != nil{
            aCoder.encode(gameImg, forKey: "game_img")
        }
        if gameTitle != nil{
            aCoder.encode(gameTitle, forKey: "game_title")
        }

    }

}
