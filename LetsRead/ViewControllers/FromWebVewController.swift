//
//  FromWebVewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import WebKit

class FromWebVewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String = ""
    var gameId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnSideMenu(_ sender: Any) {
        self.toggleRightViewAnimated(self)
    }
}
extension FromWebVewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func loaddingWebView(_ urlString: String){
        let url = URL(string: urlString)!
        self.showIndicator()
        webView.load(URLRequest(url: url))

        if webView.isLoading {
            self.hideIndicator()
        }
        webView.allowsBackForwardNavigationGestures = true
    }
    func getGames() {
        let stId = UserProfile.shared.userID ?? 0
               let request = BaseRequest()
               request.url = "gameDetails?st_id=\(stId)&game_id=\(gameId)"
               request.method = .get
               self.showIndicator()
               RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
                   self.hideIndicator()
                let data = GameDetailsModel.init(fromJson: json)
                if data.success {
                    if let game = data.details {
                        let url = game.gameHtml ?? ""
                        self.loaddingWebView(url)
                    }
                    //self.collectionView.reloadData()
                    return
                }
                    self.ErrorMessage(title: "", errorbody: data.message)
                   
        }
    }
}



import Foundation
import SwiftyJSON


class GameDetailsModel : NSObject, NSCoding{

    var success : Bool!
    var code : Int!
    var details : Detail!
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
        let detailsJson = json["details"]
        if !detailsJson.isEmpty{
            details = Detail(fromJson: detailsJson)
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
        if details != nil{
            dictionary["details"] = details.toDictionary()
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
         details = aDecoder.decodeObject(forKey: "details") as? Detail
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
        if details != nil{
            aCoder.encode(details, forKey: "details")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }

    }

}



class Detail : NSObject, NSCoding{

    var gameFree : Int!
    var gameHtml : String!
    var gameId : Int!
    var gameImg : String!
    var gameTitle : String!
    var showtoall : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        gameFree = json["game_free"].intValue
        gameHtml = json["game_html"].stringValue
        gameId = json["game_id"].intValue
        gameImg = json["game_img"].stringValue
        gameTitle = json["game_title"].stringValue
        showtoall = json["showtoall"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if gameFree != nil{
            dictionary["game_free"] = gameFree
        }
        if gameHtml != nil{
            dictionary["game_html"] = gameHtml
        }
        if gameId != nil{
            dictionary["game_id"] = gameId
        }
        if gameImg != nil{
            dictionary["game_img"] = gameImg
        }
        if gameTitle != nil{
            dictionary["game_title"] = gameTitle
        }
        if showtoall != nil{
            dictionary["showtoall"] = showtoall
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         gameFree = aDecoder.decodeObject(forKey: "game_free") as? Int
         gameHtml = aDecoder.decodeObject(forKey: "game_html") as? String
         gameId = aDecoder.decodeObject(forKey: "game_id") as? Int
         gameImg = aDecoder.decodeObject(forKey: "game_img") as? String
         gameTitle = aDecoder.decodeObject(forKey: "game_title") as? String
         showtoall = aDecoder.decodeObject(forKey: "showtoall") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if gameFree != nil{
            aCoder.encode(gameFree, forKey: "game_free")
        }
        if gameHtml != nil{
            aCoder.encode(gameHtml, forKey: "game_html")
        }
        if gameId != nil{
            aCoder.encode(gameId, forKey: "game_id")
        }
        if gameImg != nil{
            aCoder.encode(gameImg, forKey: "game_img")
        }
        if gameTitle != nil{
            aCoder.encode(gameTitle, forKey: "game_title")
        }
        if showtoall != nil{
            aCoder.encode(showtoall, forKey: "showtoall")
        }

    }

}
