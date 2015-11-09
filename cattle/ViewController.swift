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
        task.startRequest()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self .performSelector(Selector("show"), withObject: nil, afterDelay: 2.0)
    }
    
    func show(){
        
        CAProgressWidget.dismiss({ _ in})
    }
}

