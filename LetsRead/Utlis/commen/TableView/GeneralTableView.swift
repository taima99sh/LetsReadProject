//
//  GeneralTableView.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/10/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
//import SwiftyJSON

class GeneralTableView: UITableView {
    
    typealias emptyClouser = (() -> Void)
    
    //typealias jsonClouser = ((_ json: JSON) -> [Any])?

    var objects: [GeneralTableViewData] = []
    
    var generalRowHeight: CGFloat = 100
    
    var EmptyDataImage: UIImage? = UIImage()
    
    var EmptyDataTitle: String = ""
    
    var EmptyDataTitleFont: UIFont = .systemFont(ofSize: 15)
    
    var EmptyDataTitleColor: UIColor = .gray
    
    var isShowLoaderWhileRequest: Bool = false
    
    var isShowErrorMessage: Bool = false

    private var identifier: String = ""
    
    var isSelfSize: Bool = false

//    private var request: BaseRequest = BaseRequest()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
    
    private var didFinish: emptyClouser?
    func didFinishRequest(_ didFinishParameter: emptyClouser?) -> GeneralTableView {
        self.didFinish = didFinishParameter
        return self
    }
}

extension GeneralTableView {
    func withIdentifier(identifier: String) -> GeneralTableView {
        self.identifier = identifier
        return self
    }
    
//    func withRequest(request: BaseRequest) -> GeneralTableView {
//        self.request = request
//        return self
//    }
    
//    func buildRequest(jsonClouser: jsonClouser) -> GeneralTableView  {
//        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: isShowLoaderWhileRequest, showErrorMessage: isShowErrorMessage) { (json) in
//            self.buildData(objs: jsonClouser?(json))
//        }
//        return self
//    }
    
    func buildData(objs: [Any]?) {
        for item in objs ?? [] {
            self.objects.append(GeneralTableViewData.init(identifier: self.identifier, object: item, rowHeight: nil))
        }
        self.reloadData()
        self.didFinish?()
    }
}

extension GeneralTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: obj.identifier, for: indexPath) as! GeneralTableViewCell
        cell.object = obj
        cell.indexPath = indexPath
        cell.parentVC = self.parentViewController
        cell.configureCell()
        return cell
    }
    

}

extension GeneralTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GeneralTableViewCell
        cell.cellDelegate.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let obj = self.objects[indexPath.row]
        return isSelfSize ? UITableView.automaticDimension : obj.rowHeight ?? self.generalRowHeight
           
    }
    
//    tableview.rowHeight = UITableViewAutomaticDimension
//    tableview.estimatedRowHeight = 50
    
//     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let cell = tableView.cellForRow(at: indexPath) as! GeneralTableViewCell
//        cell.cellDelegate.tableView(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
//        return UISwipeActionsConfiguration(actions: [cell.edit])
//    }
}

extension GeneralTableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return EmptyDataImage ?? UIImage()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: EmptyDataTitle, attributes: [NSAttributedString.Key.font : EmptyDataTitleFont, NSAttributedString.Key.foregroundColor: EmptyDataTitleColor])
    }
    
    //
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    
}


class MyTableView: UITableView {
    
    var EmptyDataImage: UIImage? = UIImage()
    
    var EmptyDataTitle: String = ""
    
    var EmptyDataTitleFont: UIFont = Constant.shared.ProjectFont.toFont() ?? .systemFont(ofSize: 15)
    
    var EmptyDataTitleColor: UIColor = "Color".myColor
    
    let refreshcontrol = UIRefreshControl()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        refreshcontrol.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.refreshControl = refreshcontrol
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
    


}

extension MyTableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
       return EmptyDataImage ?? UIImage()
   }
   
   func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
       return NSAttributedString.init(string: EmptyDataTitle, attributes:    [NSAttributedString.Key.font : EmptyDataTitleFont,    NSAttributedString.Key.foregroundColor: EmptyDataTitleColor])
   }
   
}

