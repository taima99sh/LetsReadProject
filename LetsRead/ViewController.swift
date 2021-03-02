//
//  ViewController.swift
//  Let's Read
//
//  Created by taima on 2/23/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnHidePassword(_ sender: Any) {
        
    }
    
    @IBAction func btnSideMenu(_ sender: Any) {
        self.toggleRightViewAnimated(self)
    }
    
    @IBAction func btnLogIn(_ sender: Any) {
        
        guard self.validation() else {return}
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        let dic = [
            "username": email , //"fhanna@intertech.ps"
            "password": password
        ]
        
        let request = BaseRequest()
        request.url = "userLogin"
        request.method = .post
        request.parameters = dic
        RequestBuilder.requestWithSuccessfullRespnose(request: request) { (json) in
            let data = UserModel.init(fromJson: json)
            if data.success {
                if let user = data.userDetails {
                    if let id = user.stId,
                        let name = user.stName,
                        let token = data.token {
                        UserProfile.fillUserData(id, name, token)
                        print(token)
                        print(name)
                    }
                    let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "LGSideViewController") as! LGSideViewController
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
                return
            }
            self.ErrorMessage(title: "", errorbody: data.message)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        self.txtEmail.text = "layal"
        self.txtPassword.text = "layal1234"
        #endif
    }
}

extension ViewController {
    func validation()-> Bool {
        if !(self.txtEmail.isValidValue && self.txtPassword.isValidValue) {
            self.ErrorMessage(title: "", errorbody: "هناك حقول فارغة")
            return false
        }
        return true
    }
    
    func emailValidation() -> Bool {
        
        let txt = self.txtEmail.text ?? ""
        if !(txt.isValidEmail()) {
            self.ErrorMessage(title: "", errorbody: "البريد الالكتروني غير صحيح")
            return false
        }
        return true
    }
    
    
    func login() {
        
    }
}

