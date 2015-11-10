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

        CAProgressWidget.loading(view)

        let task = WeatherTask()
        task.startRequest { (response:Response<WeatherModel, NSError>) -> Void in
            
            CAProgressWidget.dismiss({ () -> Void in})
            print(response.result.value?.basic?.city)
            print(response.result.value?.daily_forecast?[0].date)
        }
    }
}

