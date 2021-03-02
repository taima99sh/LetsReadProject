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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if let parent = self.parentVC as? MenuViewController {
                    if let obj = self.object?.object as? Constant.MenuItems {
                        switch obj {
                        case .home:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .aboutUs:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AboutReadingViewController") as! AboutReadingViewController
                            vc.id = "68525"
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .aboutReading:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AboutReadingViewController") as! AboutReadingViewController
                            vc.id = "68527"
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .trip:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .library:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .messages:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .games:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "VideosListViwController")
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                        case .help:
                        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FromWebVewController") as! FromWebVewController
                        vc.urlString = "http://clients.intertech.ps/yallaneqra/ar/mobPage/68522"
                        AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                            
                        case .videos:
                        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "GamesViewController")
                        parent.toggleRightViewAnimated(self)
                        AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                            case .test:
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "RecordingAudioViewController") as! RecordingAudioViewController
                            parent.toggleRightViewAnimated(self)
                            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
                            
                        case .SignOut:
                            parent.showAlert(title: "", message: "هل تريد الخروج؟",button1title: "تأكيد", button2title: "إلغاء", button1action: {
                                UserDefaults.resetDefaults()
                                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "LGSideViewController") as! LGSideViewController
                                UIApplication.shared.windows.first?.rootViewController = vc
                                UIApplication.shared.windows.first?.makeKeyAndVisible()
                            }) {
                                
                            }
                        }
                    }
                }
    }
}
