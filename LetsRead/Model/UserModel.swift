//
//  UserModel.swift
//  LetsRead
//
//  Created by taima on 2/28/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel : NSObject, NSCoding{

    var success : Bool!
    var code : Int!
    var message : String!
    var token : String!
    var userDetails : UserDetail!


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
        token = json["token"].stringValue
        let userDetailsJson = json["user_details"]
        if !userDetailsJson.isEmpty{
            userDetails = UserDetail(fromJson: userDetailsJson)
        }
    }

  
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
        if token != nil{
            dictionary["token"] = token
        }
        if userDetails != nil{
            dictionary["user_details"] = userDetails.toDictionary()
        }
        return dictionary
    }

    
    @objc required init(coder aDecoder: NSCoder)
    {
         success = aDecoder.decodeObject(forKey: "Success") as? Bool
         code = aDecoder.decodeObject(forKey: "code") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String
         token = aDecoder.decodeObject(forKey: "token") as? String
         userDetails = aDecoder.decodeObject(forKey: "user_details") as? UserDetail

    }

    
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
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if userDetails != nil{
            aCoder.encode(userDetails, forKey: "user_details")
        }

    }

}

class UserDetail : NSObject, NSCoding{

    var createdAt : String!
    var currLogin : String!
    var deviceToken : String!
    var deviceType : String!
    var editedBy : Int!
    var prevLogin : String!
    var stActive : Int!
    var stAge : Int!
    var stCity : String!
    var stClass : String!
    var stDeleted : Int!
    var stEmail : String!
    var stGender : String!
    var stId : Int!
    var stLevel : Int!
    var stName : String!
    var stPassword : String!
    var stPic : String!
    var stSchool : Int!
    var stSchoolTxt : String!
    var stSection : String!
    var stT : Int!
    var stTeacherParent : Int!
    var token : String!
    var updatedAt : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        currLogin = json["curr_login"].stringValue
        deviceToken = json["device_token"].stringValue
        deviceType = json["device_type"].stringValue
        editedBy = json["edited_by"].intValue
        prevLogin = json["prev_login"].stringValue
        stActive = json["st_active"].intValue
        stAge = json["st_age"].intValue
        stCity = json["st_city"].stringValue
        stClass = json["st_class"].stringValue
        stDeleted = json["st_deleted"].intValue
        stEmail = json["st_email"].stringValue
        stGender = json["st_gender"].stringValue
        stId = json["st_id"].intValue
        stLevel = json["st_level"].intValue
        stName = json["st_name"].stringValue
        stPassword = json["st_password"].stringValue
        stPic = json["st_pic"].stringValue
        stSchool = json["st_school"].intValue
        stSchoolTxt = json["st_school_txt"].stringValue
        stSection = json["st_section"].stringValue
        stT = json["st_t"].intValue
        stTeacherParent = json["st_teacher_parent"].intValue
        token = json["token"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if currLogin != nil{
            dictionary["curr_login"] = currLogin
        }
        if deviceToken != nil{
            dictionary["device_token"] = deviceToken
        }
        if deviceType != nil{
            dictionary["device_type"] = deviceType
        }
        if editedBy != nil{
            dictionary["edited_by"] = editedBy
        }
        if prevLogin != nil{
            dictionary["prev_login"] = prevLogin
        }
        if stActive != nil{
            dictionary["st_active"] = stActive
        }
        if stAge != nil{
            dictionary["st_age"] = stAge
        }
        if stCity != nil{
            dictionary["st_city"] = stCity
        }
        if stClass != nil{
            dictionary["st_class"] = stClass
        }
        if stDeleted != nil{
            dictionary["st_deleted"] = stDeleted
        }
        if stEmail != nil{
            dictionary["st_email"] = stEmail
        }
        if stGender != nil{
            dictionary["st_gender"] = stGender
        }
        if stId != nil{
            dictionary["st_id"] = stId
        }
        if stLevel != nil{
            dictionary["st_level"] = stLevel
        }
        if stName != nil{
            dictionary["st_name"] = stName
        }
        if stPassword != nil{
            dictionary["st_password"] = stPassword
        }
        if stPic != nil{
            dictionary["st_pic"] = stPic
        }
        if stSchool != nil{
            dictionary["st_school"] = stSchool
        }
        if stSchoolTxt != nil{
            dictionary["st_school_txt"] = stSchoolTxt
        }
        if stSection != nil{
            dictionary["st_section"] = stSection
        }
        if stT != nil{
            dictionary["st_t"] = stT
        }
        if stTeacherParent != nil{
            dictionary["st_teacher_parent"] = stTeacherParent
        }
        if token != nil{
            dictionary["token"] = token
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currLogin = aDecoder.decodeObject(forKey: "curr_login") as? String
         deviceToken = aDecoder.decodeObject(forKey: "device_token") as? String
         deviceType = aDecoder.decodeObject(forKey: "device_type") as? String
         editedBy = aDecoder.decodeObject(forKey: "edited_by") as? Int
         prevLogin = aDecoder.decodeObject(forKey: "prev_login") as? String
         stActive = aDecoder.decodeObject(forKey: "st_active") as? Int
         stAge = aDecoder.decodeObject(forKey: "st_age") as? Int
         stCity = aDecoder.decodeObject(forKey: "st_city") as? String
         stClass = aDecoder.decodeObject(forKey: "st_class") as? String
         stDeleted = aDecoder.decodeObject(forKey: "st_deleted") as? Int
         stEmail = aDecoder.decodeObject(forKey: "st_email") as? String
         stGender = aDecoder.decodeObject(forKey: "st_gender") as? String
         stId = aDecoder.decodeObject(forKey: "st_id") as? Int
         stLevel = aDecoder.decodeObject(forKey: "st_level") as? Int
         stName = aDecoder.decodeObject(forKey: "st_name") as? String
         stPassword = aDecoder.decodeObject(forKey: "st_password") as? String
         stPic = aDecoder.decodeObject(forKey: "st_pic") as? String
         stSchool = aDecoder.decodeObject(forKey: "st_school") as? Int
         stSchoolTxt = aDecoder.decodeObject(forKey: "st_school_txt") as? String
         stSection = aDecoder.decodeObject(forKey: "st_section") as? String
         stT = aDecoder.decodeObject(forKey: "st_t") as? Int
         stTeacherParent = aDecoder.decodeObject(forKey: "st_teacher_parent") as? Int
         token = aDecoder.decodeObject(forKey: "token") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if currLogin != nil{
            aCoder.encode(currLogin, forKey: "curr_login")
        }
        if deviceToken != nil{
            aCoder.encode(deviceToken, forKey: "device_token")
        }
        if deviceType != nil{
            aCoder.encode(deviceType, forKey: "device_type")
        }
        if editedBy != nil{
            aCoder.encode(editedBy, forKey: "edited_by")
        }
        if prevLogin != nil{
            aCoder.encode(prevLogin, forKey: "prev_login")
        }
        if stActive != nil{
            aCoder.encode(stActive, forKey: "st_active")
        }
        if stAge != nil{
            aCoder.encode(stAge, forKey: "st_age")
        }
        if stCity != nil{
            aCoder.encode(stCity, forKey: "st_city")
        }
        if stClass != nil{
            aCoder.encode(stClass, forKey: "st_class")
        }
        if stDeleted != nil{
            aCoder.encode(stDeleted, forKey: "st_deleted")
        }
        if stEmail != nil{
            aCoder.encode(stEmail, forKey: "st_email")
        }
        if stGender != nil{
            aCoder.encode(stGender, forKey: "st_gender")
        }
        if stId != nil{
            aCoder.encode(stId, forKey: "st_id")
        }
        if stLevel != nil{
            aCoder.encode(stLevel, forKey: "st_level")
        }
        if stName != nil{
            aCoder.encode(stName, forKey: "st_name")
        }
        if stPassword != nil{
            aCoder.encode(stPassword, forKey: "st_password")
        }
        if stPic != nil{
            aCoder.encode(stPic, forKey: "st_pic")
        }
        if stSchool != nil{
            aCoder.encode(stSchool, forKey: "st_school")
        }
        if stSchoolTxt != nil{
            aCoder.encode(stSchoolTxt, forKey: "st_school_txt")
        }
        if stSection != nil{
            aCoder.encode(stSection, forKey: "st_section")
        }
        if stT != nil{
            aCoder.encode(stT, forKey: "st_t")
        }
        if stTeacherParent != nil{
            aCoder.encode(stTeacherParent, forKey: "st_teacher_parent")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
