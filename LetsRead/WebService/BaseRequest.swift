//
//  BaseRequest.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 10/15/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class BaseRequest {
    
    var url: String = "http://clients.intertech.ps/yallaneqra/WS/"
    
    var parameters: [String : Any] = [:]
    
    var method: HTTPMethod = .get
    
    var files: [BaseFile] = []
}

