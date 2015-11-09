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
    
    /// 单例
    static let sharedInstance = CAProgressWidget()
    /// 黑色背景圆角
    static let blackViewRadius: CGFloat = 10.0
    /// 黑色背景透明度
    static let blackViewAlpha: CGFloat = 0.8
    /// 黑色背景边长
    let blackViewWH: CGFloat = 100.0
    /// 标签高度
    let labelHeight: CGFloat = 15.0
    /// 间距
    let margin: CGFloat = 10.0
    /// 控件显示的最长时间
    let timeout: Double = 20.0
    /// 提示信息展示时间
    let shortTimeout: Double = 2.0
    /// 动画时间，秒为单位
    let animateTime: Double = 0.2

    lazy var label: UILabel? = {
        var tmpLbl = UILabel()
        tmpLbl.textColor = UIColor.whiteColor()
        tmpLbl.textAlignment = NSTextAlignment.Center
        tmpLbl.font = UIFont.systemFontOfSize(12)
        return tmpLbl
    }()
	
    lazy var detailLabel: UILabel? = {
        var tmpLbl = UILabel()
        tmpLbl.textColor = UIColor.whiteColor()
        tmpLbl.textAlignment = NSTextAlignment.Center
        tmpLbl.font = UIFont.systemFontOfSize(12)
        return tmpLbl
    }()
	
    lazy var blackView: UIView? = {
        var tmpView = UIView()
        tmpView.backgroundColor = UIColor.blackColor()
        tmpView.layer.cornerRadius = blackViewRadius
        tmpView.layer.masksToBounds = true
        tmpView.alpha = blackViewAlpha
        return tmpView
    }()
	
    var progressView: UIActivityIndicatorView? = {
        var tmpView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        return tmpView
    }()
	
    // MARK: - Private Methods
    
    func dismissLoading(animated:NSNumber, didDissmiss: () -> Void) -> Void{
        
        if superview == nil {
            return
        }
        
        if animated.boolValue{
            
            UIView.animateWithDuration(animateTime, animations: { () -> Void in
                self.alpha = 0
            }) { (isFininshed) -> Void in
                self.removeAllSubViews()
                self.removeFromSuperview()
                didDissmiss()
            }
            
        }else{
            removeAllSubViews()
            removeFromSuperview()
            didDissmiss()
        }
    }
    
    func dismissLoading(animated: NSNumber) -> Void{
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        
        if superview == nil {
            return
        }
        
        if animated.boolValue {
            
            UIView.animateWithDuration(animateTime, animations: { () -> Void in
                self.alpha = 0
            }) { (isFininshed) -> Void in
                self.removeAllSubViews()
                self.removeFromSuperview()
            }
            
        }else{
            removeAllSubViews()
            removeFromSuperview()
        }
    }
    
    func showLoading(inView: UIView?, text: String?, detailText: String?) {

        //如果已经显示了，先隐藏
        if superview != nil{
            dismissLoading(NSNumber(bool: false))
        }
        
        //设置黑色背景和菊花
        if inView != nil && blackView != nil && progressView != nil{
            
            alpha = 0
            frame = inView!.bounds
            backgroundColor = UIColor.clearColor()
            inView?.addSubview(self)
            
            blackView?.ca_size(CGSize(width: blackViewWH, height: blackViewWH))
            blackView?.ca_center(inView!.ca_center())
            addSubview(blackView!)
            
            progressView?.ca_center(inView!.ca_center())
            addSubview(progressView!)
            
            //设置标题
            if text != nil && label != nil{
                progressView?.ca_addY(-margin)
                addSubview(label!)
                label?.frame = CGRect(x: blackView!.ca_minX(), y: progressView!.ca_maxY() + margin, width: blackView!.ca_width(), height: labelHeight)
                label?.text = text
                
                //设置描述
                if detailText != nil && detailLabel != nil{
                    
                    progressView?.ca_addY(-margin)
                    label?.ca_addY(-margin)
                    
                    addSubview(detailLabel!)
                    detailLabel?.frame = CGRect(x: blackView!.ca_minX(), y: label!.ca_maxY() + margin/2.0, width: blackView!.ca_width(), height: labelHeight)
                    detailLabel?.text = detailText
                }
            }
            
            //显示
            UIView.animateWithDuration(animateTime, animations: { () -> Void in
                self.alpha = 1.0
            }, completion: { (finished) -> Void in
                self.progressView?.startAnimating()
                self.performSelector(Selector("dismissLoading:"), withObject: NSNumber(bool: true), afterDelay: self.timeout)
            })
        }
    }
    
    func dismissMessage(animated: NSNumber) -> Void{
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        
        if animated.boolValue{
            
            UIView.animateWithDuration(animateTime, animations: { () -> Void in
                self.ca_addY(20.0)
                self.alpha = 0
            }) { (isFininshed) -> Void in
                self.removeAllSubViews()
                self.removeFromSuperview()
            }
            
        }else{
            removeAllSubViews()
            removeFromSuperview()
        }
    }
    
    func showMessage(inView: UIView?, text: String?) {
        
        //如果已经显示了，先隐藏
        if superview != nil{
            dismissMessage(NSNumber(bool: false))
        }
        
        if inView != nil && text != nil && blackView != nil && label != nil{
            
            alpha = 0
            frame = inView!.bounds
            backgroundColor = UIColor.clearColor()
            inView?.addSubview(self)
            
            addSubview(blackView!)
            addSubview(label!)
            
            label?.text = text
            label?.numberOfLines = 2
            let attributes = NSDictionary(object: label!.font, forKey: NSFontAttributeName)
            let size = label?.text?.boundingRectWithSize(CGSize(width: 200, height: 200), options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: attributes as? [String : AnyObject], context: nil)
            label?.frame = CGRect(x: 0, y: 0, width: 200, height: (size?.height)! + 30)
            label?.ca_center(ca_center())
            label?.ca_addY(-20.0)
            
            blackView!.frame = label!.frame
            
            //显示
            UIView.animateWithDuration(animateTime, animations: { () -> Void in
                self.alpha = 1.0
                self.label?.ca_addY(20.0)
                self.blackView!.frame = self.label!.frame
            }, completion: { (finished) -> Void in
                self.performSelector(Selector("dismissMessage:"), withObject:  NSNumber(bool: true), afterDelay: self.shortTimeout)
            })
        }
    }

	
	// MARK: - Class Methods
    
    /**
        展示加载框
    
        - parameter inView: 父视图
    */
    class func loading(inView: UIView?) -> Void  {
        sharedInstance.showLoading(inView, text: nil, detailText: nil)
    }
	
    /**
        展示带标题的加载框
	
        - parameter superView: 父视图
        - parameter text:      标题内容
    */
    class func loading(inView: UIView?, text:String?) -> Void {
        sharedInstance.showLoading(inView, text: text, detailText: nil)
    }
	
    /**
        展示带标题和描述的加载框
    
        - parameter superView:  父视图
        - parameter text:       标题内容
        - parameter detailText: 描述内容
    */
    class func loading(inView: UIView?, text: String?, detailText: String?) -> Void{
        sharedInstance.showLoading(inView, text: text, detailText: detailText)
    }
    
    /**
        消息提示【几秒钟自动消失】
    
        - parameter text:   提示信息
    */
    class func message(text:String?) -> Void{
        let window: UIWindow? = UIApplication.sharedApplication().keyWindow
        sharedInstance.showMessage(window, text: text)
    }
	
    /**
        隐藏加载框
    */
    class func dismiss(didDissmiss: () -> Void) -> Void {
        sharedInstance.dismissLoading(NSNumber(bool: true), didDissmiss: didDissmiss)
    }
}
