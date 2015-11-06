//
//  WeatherTask.swift
//  cattle
//
//  Created by lawn on 15/11/5.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import Foundation

class WeatherTask: NetworkTask {
	
    var cityid:String = "CN10101010018A"

    override func requestPath() ->String{
        return "heweather/pro/attractions"
    }

    override func requestHeaders() ->[String:String]{
        return ["apikey":"e6cbf0f257a3155b569bee7e48959809"]
    }

    override func requestMethod() -> HttpMethod{
        return .GET
    }
}

