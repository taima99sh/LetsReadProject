//
//  QuestionsCollectionViewCell.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class QuestionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblChoice: UILabel!
    
    var object: String?
    
    func configureCell() {
        if let obj = object {
            lblChoice.text = obj
        }
    }
    
}
