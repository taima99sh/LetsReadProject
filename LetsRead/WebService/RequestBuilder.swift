//
//  RequestBuilder.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 10/15/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import MBProgressHUD

class RequestBuilder {
    static let shared = RequestBuilder()
    
    static var headers: HTTPHeaders {
        let dic: HTTPHeaders = ["token": UserProfile.shared.userToken ?? "",
                                    "Accept":"application/json"]
        let method: HTTPMethod = .post
        return dic
    }
    
    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = AppDelegate.shared.rootNavigationViewController
           while parentResponder != nil {
               parentResponder = parentResponder!.next
               if let viewController = parentResponder as? UIViewController {
                   return viewController
               }
           }
           return nil
       }
    
    class func request(request: BaseRequest, showLoader: Bool = true, success: @escaping ((_ json: JSON) -> Void), failure: @escaping ((_ error: Error) -> Void)) {
        guard let url = URL.init(string: "\(GlobalConstants.APIV)\(request.url)") else { return }
        if showLoader {
            self.showLoader(isShowLoader: true)
        }
        if request.files.count > 0 {
            AF.upload(multipartFormData: { (multi) in
                for item in request.files {
                    if let data = item.data {
                        multi.append(data, withName: item.name ?? "data", fileName: item.fileName, mimeType: item.type.rawValue)
                    }
                }
                for (key, value) in request.parameters {
                    if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                        multi.append(data, withName: key)
                    }
                }
            }, to: url, method: request.method, headers: self.headers, interceptor: nil).uploadProgress { (progress) in
                self.showLoader(inProgress: progress.fractionCompleted)
            }.responseData { response in
                ResponseHandler.responseHandler(response: response, showLoader: showLoader, request: request, url: url, success: success, failure: failure)
            }
        } else {
            AF.request(url, method: request.method, parameters: request.parameters, headers: self.headers, interceptor: nil).validate().responseData { (response) in
                ResponseHandler.responseHandler(response: response, showLoader: showLoader, request: request, url: url, success: success, failure: failure)
            }
        }
    }
    
    class func requestWithSuccessfullRespnose(request: BaseRequest, showLoader: Bool = true, showErrorMessage: Bool = true, success: @escaping ((_ json: JSON) -> Void)) {
        self.request(request: request, showLoader: showLoader, success: { (json) in
            success(json)
        }) { (error) in
            if showErrorMessage {
                RequestBuilder.shared.parentViewController?.ErrorMessage(title: "ERROR", errorbody: error.localizedDescription)
            }
        }
    }
    
    class func showLoader(isShowLoader: Bool) {
        if isShowLoader {
            let Indicator = MBProgressHUD.showAdded(to: AppDelegate.shared.window ?? UIView(), animated: true)
            Indicator.label.text = "Indicator"
            Indicator.isUserInteractionEnabled = false
            Indicator.detailsLabel.text = "fetching details"
            Indicator.show(animated: true)
            //MBProgressHUD.
//            SVProgressHUD.setDefaultMaskType(.custom)
//            SVProgressHUD.setForegroundColor("1E92C4".color_)
//            SVProgressHUD.setBackgroundColor(UIColor.white)
//            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    class func showLoader(inProgress: Double) {
//        SVProgressHUD.setDefaultMaskType(.custom)
//        SVProgressHUD.setForegroundColor("1E92C4".color_)
//        SVProgressHUD.setBackgroundColor(UIColor.white)
//        SVProgressHUD.showProgress(Float(inProgress))
    }
}
