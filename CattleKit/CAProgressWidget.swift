//
//  CAProgressWidget.swift
//  cattle
//
//  Created by lawn on 15/11/5.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import UIKit

public class CAProgressWidget: UIView {
	
    // MARK: - Property
    
    public enum CAProgressWidgetModel:String{ case Indeterminate, Determinate, DeterminateHorizontalBar, AnnularDeterminate, CustomView, Text}
	
    static let s = CAProgressWidget()
    static let blackViewWH: CGFloat = 80.0
    static let blackViewRadius: CGFloat = 10.0
    static let margin: CGFloat = 10.0
    static let labelHeight: CGFloat = 20.0
    static let timeout: Double = 20.0
    var showModel: CAProgressWidgetModel = .Indeterminate

    lazy var label: UILabel? = {
        var tmpLbl = UILabel()
        tmpLbl.ca_size(CGSize(width: blackViewWH, height: labelHeight))
        tmpLbl.textColor = UIColor.whiteColor()
        tmpLbl.textAlignment = NSTextAlignment.Center
        tmpLbl.font = UIFont.systemFontOfSize(12)
        return tmpLbl
    }()
	
    lazy var detailLabel: UILabel? = {
        var tmpLbl = UILabel()
        tmpLbl.ca_size(CGSize(width: blackViewWH, height: labelHeight))
        tmpLbl.textColor = UIColor.whiteColor()
        return tmpLbl
    }()
	
    lazy var blackView: UIView? = {
        var tmpView = UIView()
        tmpView.ca_size(CGSize(width: blackViewWH, height: blackViewWH))
        tmpView.backgroundColor = UIColor.blackColor()
        tmpView.layer.cornerRadius = blackViewRadius
        tmpView.layer.masksToBounds = true
        tmpView.alpha = 0.8
        return tmpView
    }()
	
    var progressView: UIActivityIndicatorView? = {
        var tmpView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        return tmpView
    }()
	
    // MARK: - Private Methods
    
    func dismiss() -> Void{
		
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
		
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.alpha = CGFloat(0)
        }) { (isFininshed) -> Void in
                self.label?.text = nil
                self.detailLabel?.text = nil
                self.removeFromSuperview()
        }
    }
	
	// MARK: - Class Methods
    
    /**
        展示加载框
    
        - parameter superView: 父视图
    */
    class func show(superView: UIView?) -> Void  {
		
        if superView != nil{
			
            superView!.addSubview(s)
            s.alpha = CGFloat(0)
            s.frame = superView!.bounds
            s.backgroundColor = UIColor.clearColor()
			
            if s.blackView != nil{
                s.addSubview(s.blackView!)
                s.blackView!.ca_center(superView!.ca_center())
            }
			
            if s.progressView != nil{
                s.addSubview(s.progressView!)
                s.progressView!.ca_center(superView!.ca_center())
                s.progressView!.startAnimating()
            }
			
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                s.alpha = CGFloat(1.0)
            })
            
            s.performSelector(Selector("dismiss"), withObject: nil, afterDelay: timeout)
        }
    }
	
    /**
        展示带标题的加载框
	
        - parameter superView: 父视图
        - parameter text:      标题内容
    */
    class func show(superView: UIView?, text:String?) -> Void {
        
        if superView != nil{
            
            CAProgressWidget.show(superView)
            
            if s.progressView != nil && s.label != nil{
                s.progressView!.ca_minY(s.blackView!.ca_minY() + margin)
                
                s.addSubview(s.label!)
                s.label!.ca_minX(s.blackView!.ca_minX())
                s.label!.ca_minY(s.blackView!.ca_centerY() + margin)
                s.label?.text = text
            }
        }
    }
	
    /**
        展示带标题和描述的加载框
    
        - parameter superView:  父视图
        - parameter text:       标题内容
        - parameter detailText: 描述内容
    */
    class func show(superView: UIView?, text: String?, detailText: String?) {
		
        if superView != nil{
            CAProgressWidget.show(superView, text: text)
        }
		
		
    }
	
    /**
        隐藏加载框
    */
    class func dismiss() -> Void {
        s.dismiss()
    }
}
