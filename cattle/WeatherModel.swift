//
//  WeatherModel.swift
//  cattle
//
//  Created by lawn on 15/11/9.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import Alamofire

final class Update: ResponseObjectSerializable {
    
    var utc:String?
    var loc:String?

    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        utc = representation.valueForKeyPath("utc") as? String
        loc = representation.valueForKeyPath("loc") as? String
    }
}

final class Basic:ResponseObjectSerializable {
    
    var update:Update?
    var id:String?
    var lon:String?
    var cnty:String?
    var lat:String?
    var city:String?
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        update = Update(response: response, representation: representation.valueForKeyPath("update")!)
        id = representation.valueForKeyPath("id") as? String
        lon = representation.valueForKeyPath("lon") as? String
        cnty = representation.valueForKeyPath("cnty") as? String
        lat = representation.valueForKeyPath("lat") as? String
        city = representation.valueForKeyPath("city") as? String
    }
}

final class DailyForecast: ResponseObjectSerializable {
    
    var dir:String?
    var sc:String?
    var sr:String?
    var ss:String?
    var min:String?
    var max:String?
    var date:String?
    var code_d:String?
    var code_n:String?
    var txt_n:String?
    var txt_d:String?

    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        
        dir = representation.valueForKeyPath("wind.dir") as? String
        sc = representation.valueForKeyPath("wind.sc") as? String
        sr = representation.valueForKeyPath("astro.sr") as? String
        ss = representation.valueForKeyPath("astro.ss") as? String
        min = representation.valueForKeyPath("tmp.min") as? String
        max = representation.valueForKeyPath("tmp.max") as? String
        date = representation.valueForKeyPath("date") as? String
        code_d = representation.valueForKeyPath("cond.code_d") as? String
        code_n = representation.valueForKeyPath("cond.code_n") as? String
        txt_n = representation.valueForKeyPath("cond.txt_n") as? String
        txt_d = representation.valueForKeyPath("cond.txt_d") as? String
    }
}

final class WeatherModel: ResponseObjectSerializable {
    
    var status:String?
    var basic:Basic?
    var daily_forecast:[DailyForecast]?
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        
        if let arr = representation.valueForKeyPath("HeWeather data service 3.0") as? NSArray {
            
            if arr.count > 0 {
                let item = arr[0]
                status = item.valueForKeyPath("status") as? String
                basic = Basic(response: response, representation: item.valueForKeyPath("basic")!)
                
                let forecastArr = (item.valueForKeyPath("daily_forecast") as! NSArray) as Array
                daily_forecast = [DailyForecast]()
                for forcast in forecastArr{
                    let dailyForecast = DailyForecast(response: response, representation: forcast)
                    daily_forecast?.append(dailyForecast!)
                }
            }
            
        }else{
            print("=====internal error")
        }
    }
}