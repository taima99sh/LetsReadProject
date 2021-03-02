//
//  GeneralTableViewCell.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/10/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import UIKit

protocol GeneralTableViewCellDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
}

class GeneralTableViewCell: UITableViewCell, GeneralTableViewCellDelegate {

    var cellDelegate: GeneralTableViewCellDelegate!
    
    var object: GeneralTableViewData?
    
    var parentVC: UIViewController?
    
    var indexPath: IndexPath!
    
    var edit: UIContextualAction = UIContextualAction()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellDelegate = self
    }

    func configureCell() {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [(edit)])
    }
}
