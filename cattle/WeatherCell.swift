//
//  WeatherCell.swift
//  cattle
//
//  Created by lawn on 15/11/10.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    
    lazy var dayLbl: UILabel = UILabel()
    lazy var sunriseLbl: UILabel = UILabel()
    lazy var sunsetLbl: UILabel = UILabel()
    lazy var tmpLbl: UILabel = UILabel()


    var dailyForecast: DailyForecast?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dayLbl.textColor = UIColor.blackColor()
        dayLbl.font = UIFont.systemFontOfSize(12)
        dayLbl.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(dayLbl)
        
        sunriseLbl.textColor = UIColor.blackColor()
        sunriseLbl.font = UIFont.systemFontOfSize(12)
        sunriseLbl.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(sunriseLbl)
        
        sunsetLbl.textColor = UIColor.blackColor()
        sunsetLbl.font = UIFont.systemFontOfSize(12)
        sunsetLbl.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(sunsetLbl)
        
        tmpLbl.textColor = UIColor.blackColor()
        tmpLbl.font = UIFont.systemFontOfSize(14)
        tmpLbl.backgroundColor = UIColor.whiteColor()
        tmpLbl.textAlignment = NSTextAlignment.Center
        contentView.addSubview(tmpLbl)
        
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let forecast = dailyForecast{
         
            dayLbl.text = "日期：\(forecast.date!)"
            sunriseLbl.text = "日出时间：\(forecast.sr!)"
            sunsetLbl.text = "日落时间：\(forecast.ss!)"
            
            var tmp:String
            if forecast.min != nil{
                tmp = "温度：\(forecast.min!)℃"
            }else{
                tmp = "温度：未知"
            }
            
            if forecast.max != nil{
                tmp = tmp + "-\(forecast.max!)℃"
            }else{
                tmp = tmp + "-未知"
            }
            tmpLbl.text = tmp
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        dayLbl.snp_updateConstraints(closure: { (make) -> Void in
            make.leading.equalTo(self.contentView.snp_leading).offset(20)
            make.trailing.equalTo(self.contentView.snp_centerX)
            make.top.equalTo(self.contentView.snp_top)
            make.bottom.equalTo(self.contentView.snp_centerY)
        })
        
        sunriseLbl.snp_updateConstraints(closure: { (make) -> Void in
            make.leading.equalTo(self.contentView.snp_centerX)
            make.trailing.equalTo(self.contentView.snp_trailing)
            make.top.equalTo(self.contentView.snp_top)
            make.bottom.equalTo(self.contentView.snp_centerY)
        })
        
        sunsetLbl.snp_updateConstraints(closure: { (make) -> Void in
            make.leading.equalTo(self.contentView.snp_centerX)
            make.trailing.equalTo(self.contentView.snp_trailing)
            make.top.equalTo(self.contentView.snp_centerY)
            make.bottom.equalTo(self.contentView.snp_bottom)
        })
        
        tmpLbl.snp_updateConstraints(closure: { (make) -> Void in
            make.leading.equalTo(self.contentView.snp_leading)
            make.trailing.equalTo(self.contentView.snp_centerX)
            make.top.equalTo(self.contentView.snp_centerY)
            make.bottom.equalTo(self.contentView.snp_bottom)
        })
    }
}