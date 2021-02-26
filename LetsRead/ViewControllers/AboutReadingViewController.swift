//
//  AboutReadingViewController.swift
//  LetsRead
//
//  Created by taima on 2/25/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class AboutReadingViewController: UIViewController {
    
    @IBOutlet weak var txtView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension AboutReadingViewController {
    func setupView(){
        txtView.text = "\r\n\r\n\t\r\n\r\n\r\n&nbsp;مهارات القراءة الخمس الأساسية\r\n\r\nتهدف الكتب والقصص المدرجة ضمن منصة &quot;يلا نقرأ&quot; والأنشطة المتربطة بها على تنمية مهارات القراءة الخمس الأساسية[1]:\r\n\r\n1-&nbsp;الوعي الصوتي: المهارة التي تندرج تحت علم الأصوات اللغوية والتي تتضمن القدرة على سماع الأصوات المنفردة (أصوات الحروف)، وتعريفها، والتلاعب بها.\r\n\r\n2- الطريقة الصوتية: استراتيجيات لفك ترميز الكلمات[2] ذات المقاطع المتعددة والتي تتضمن مورفولوجي )علم الصرف( ومعلومات حول المعنى، واللفظ، وأجزاء الكلام للكلمات المكتسبة من معرفة السوابق، والجذور، واللواحق.\r\n\r\n3- الطلاقة: القدرة على قراءة النص بسرعة وبدقة مع التعبير.\r\n\r\n4- المفردات: تُشير إلى جميع الكلمات في لغتنا، وعلى المرء معرفة حصيلة من كلمات حتى يتمكن من التواصل بشكل فعّال. وتُعتبر المفردات مهمة لفهم المقروء، لأن القرّاء لا يستطيعون فهم ما يقرؤون بدون معرفة معظم معاني الكلمات التي يقرؤون".html2Attributed?.string
    }
    func localized(){}
    func setupData(){}
    func fetchData(){}
}
