//
//  MessageTableViewCell.swift
//  LetsRead
//
//  Created by taima on 2/28/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var object: Message?
    
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!

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
            self.lblDate.text = (obj.createdAt ?? "").toDate(customFormat: "yyyy-MM-dd'T'HH:mm:ssZ").toString(customFormat: "MMM d, h:mm a")
            self.lblSender.text = obj.senderName ?? ""
            self.lblMessage.text = obj.body ?? ""
        }
    }
}
