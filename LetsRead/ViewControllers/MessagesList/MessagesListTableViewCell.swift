//
//  MessagesListTableViewCell.swift
//  LetsRead
//
//  Created by taima on 3/3/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MessagesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSender:UILabel!
    
    var object: Message?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        if let obj = object {
            self.lblTitle.text = obj.title ?? ""
            self.lblSender.text = obj.body ?? ""
        }
    }

}
