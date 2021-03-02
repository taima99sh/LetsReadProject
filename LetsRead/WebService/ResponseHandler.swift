//
//  ResponseHandler.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 10/15/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ResponseHandler {
    static let shared = ResponseHandler()
    
    static func responseHandler(response: AFDataResponse<Data>, showLoader: Bool = true, request: BaseRequest, url: URL ,success: @escaping ((_ json: JSON) -> Void), failure: @escaping ((_ error: Error) -> Void)) {
        debugPrint("************************* Request *************************")
        debugPrint("The url: \(url.absoluteString)")
        RequestBuilder.showLoader(isShowLoader: false)
        switch response.result {
            case .success(let data):
                do {
                    let json = try JSON.init(data: data)
                    debugPrint("Methods: \(request.method.rawValue)")
                    debugPrint("Response: \(json.dictionaryValue)")
                    debugPrint("************************* Request *************************")
//                    if json["status"].boolValue == true {
                        success(json)
//                    } else {
//                        let error = NSError.init(domain: json["message"].stringValue, code: json["code"].intValue, userInfo: nil)
//                        failure(error)
//                    }
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                    failure(error)
                }
                break
            case .failure(let error):
                debugPrint(error.localizedDescription)
                failure(error)
                break
        }
    }
}
