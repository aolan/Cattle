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
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	
		
		let task = WeatherTask()
		task.startRequest()
	}

}

