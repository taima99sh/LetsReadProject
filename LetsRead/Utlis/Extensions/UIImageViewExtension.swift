//
//  UIImageViewExtension.swift
//  Yahia Gallery
//
//  Created by taima on 3/19/20.
//  Copyright © 2020 mac air. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func LoadImageFromUrl(url: String?, placeholder: String = "cellImage") {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL.init(string: url ?? "https://hyakah.com/"), placeholder: placeholder.image_)
    }
}

