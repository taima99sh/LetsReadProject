//
//  Connectivity.swift
//  Istsharat
//
//  Created by taima on 2/8/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
