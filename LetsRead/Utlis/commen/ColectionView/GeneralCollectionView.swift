//
//  GeneralCollectionView.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/19/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class GeneralCollectionView: UICollectionView {
    
    var EmptyDataImage: UIImage? = UIImage()
    
    var EmptyDataTitle: String = ""
    
    var EmptyDataTitleFont: UIFont = .systemFont(ofSize: 15)
    
    var EmptyDataTitleColor: UIColor = .gray
    
    var isSelfSize: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                if self.isSelfSize {
                    if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
                       flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                    }
                }
            }
        }
    }

    var objects: [GeneralCollectionViewData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        if isSelfSize {
        }
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        let s = self.collectionViewLayout.collectionViewContentSize
        return CGSize(width: max(s.width, 1), height: max(s.height,1))
    }
}

extension GeneralCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = self.objects[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: obj.identifier ?? "", for: indexPath) as! GeneralCollectionViewCell
        cell.object = obj
        cell.indexPath = indexPath
        cell.parentVC = self.parentViewController 
        print(self.parentViewController)
        print("*************\(cell.parentVC)***************")
        cell.configureCell()
        return cell
    }
}

extension GeneralCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GeneralCollectionViewCell
        cell.cellDelegate.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

extension GeneralCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let obj = self.objects[indexPath.row]
        return obj.cellSize ?? CGSize.init(width: 1, height: 1)
    }
}

extension GeneralCollectionView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return EmptyDataImage ?? UIImage()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: EmptyDataTitle, attributes: [NSAttributedString.Key.font : EmptyDataTitleFont, NSAttributedString.Key.foregroundColor: EmptyDataTitleColor])
    }
}
//istsharat

class MyCollectionView: UICollectionView {
    
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

extension MyCollectionView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
       return EmptyDataImage ?? UIImage()
   }
   
   func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
       return NSAttributedString.init(string: EmptyDataTitle, attributes:    [NSAttributedString.Key.font : EmptyDataTitleFont,    NSAttributedString.Key.foregroundColor: EmptyDataTitleColor])
   }
   
}
