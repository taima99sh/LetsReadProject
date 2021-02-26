//
//  MenuTableViewCell.swift
//  LetsRead
//
//  Created by taima on 2/24/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MenuTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        if let obj = self.object?.object as? Constant.MenuItems {
            self.lblTitle.text = obj.name
            if isUserLogin {
                self.isHidden = true
            }
            
        }
    }
}
