//
//  FileBase.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 10/15/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation

enum FileDataType: String {
    case image = "image/png"
    case video = "video/mp4"
    case audio = "audio/m4a"
}

class BaseFile {
    
    var data: Data?
    
    var name: String?
    
    var type: FileDataType = .image
    
    var fileName: String {
        switch type {
        case .image:
            return "\(self.name ?? "image").png"
        case .video:
            return "\(self.name ?? "video").mp4"
        case .audio:
            return "\(self.name ?? "audio").m4a"
        }
    }
}
