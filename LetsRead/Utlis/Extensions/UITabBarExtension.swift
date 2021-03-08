//
//  UITabBarExtension.swift
//  Yahia Gallery
//
//  Created by taima on 11/23/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
   @IBInspectable var  isShowOriginalColors: Bool{
        set {
            for (_, item) in (self.items ?? []).enumerated() {
             let img =   item.selectedImage?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = newValue == true ? img : self.shadowImage
            }
        }
        get{
            return false
        }
    }
    
    @IBInspectable var nonSelectionColor: UIColor {
        set{
            self.unselectedItemTintColor = newValue
        }
        get{
           return self.unselectedItemTintColor ?? .gray
        }
    }
}
