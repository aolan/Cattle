//
//  ViewController.swift
//  cattle
//
//  Created by lawn on 15/10/29.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "天气预报"
        view.backgroundColor = UIColor.whiteColor()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
	
//        CAProgressWidget.loading(view, text: "加载中...", detailText: "努力")
        CAProgressWidget.message("您的账户余额已不足，请尽快充值")
        
        let task = WeatherTask()
        task.startRequest()
    }
}

