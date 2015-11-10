//
//  ViewController.swift
//  cattle
//
//  Created by lawn on 15/10/29.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var weatherModel:WeatherModel?
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    lazy var tableView:UITableView = {
    
        var tmpTableView:UITableView = UITableView(frame: CGRectZero, style:UITableViewStyle.Plain)
        tmpTableView.dataSource = self
        tmpTableView.delegate = self
        tmpTableView.showsVerticalScrollIndicator = false
        tmpTableView.registerClass(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        return tmpTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "天气预报"
        view.backgroundColor = UIColor.whiteColor()
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        refreshData()
    }
    
    func refreshData(){
        
        CAProgressWidget.loading(view)
        
        let task = WeatherTask()
        task.startRequest { (response:Response<WeatherModel, NSError>) -> Void in
            CAProgressWidget.dismiss({ () -> Void in})
            self.weatherModel = response.result.value
            self.tableView.reloadData()
            if self.refreshControl.refreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK :- UITableViewDataSource && UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WeatherCell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! WeatherCell
        
        if weatherModel?.daily_forecast?.count > indexPath.row {
            
            if let item = weatherModel?.daily_forecast?[indexPath.row] {
                cell.dailyForecast = item
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if weatherModel?.daily_forecast?.count > 0{
            return (weatherModel?.daily_forecast?.count)!
        }else{
            return 0
        }
    }
}

