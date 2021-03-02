//
//  File.swift
//  Istsharat
//
//  Created by taima on 2/1/21.
//  Copyright © 2021 mac air. All rights reserved.

import Foundation
import  UIKit

class Constant {
    static let shared = Constant()
    var ProjectFont = "Helvetica Neue W23 for SKY"
    
    enum MenuItems {
        case library
        case test
        case videos
        case games
        case help
        case messages
        case aboutUs
        case SignOut
        case aboutReading
        case trip
        case home
        
        var name:String {
            
            switch self {
            
            case .library:
                return  "مكتبتي"
            case .test:
              return  "اختبار"
            case .videos:
              return  "فيديوهات"
            case .games:
              return "ألعاب"
            case .help:
              return "مساعدة"
            case .messages:
              return "رسائلي"
            case .aboutUs:
              return "تعرف علينا"
            case .SignOut:
              return "خروج"
            case .aboutReading:
                return "عن القراءة"
            case .trip:
                return "جولة"
            case .home:
                return "الرئيسية"
            }
        }
    }
}

class APIConstant {
    
    static let shared = APIConstant()
    var api = "http://clients.intertech.ps/yallaneqra/WS/"
}

