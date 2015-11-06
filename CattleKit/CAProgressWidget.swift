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
    
    /**
        控件类型定义
    */
    public enum CAProgressWidgetModel:String{ case Indeterminate, Determinate, DeterminateHorizontalBar, AnnularDeterminate, CustomView, Text}
	
    /// 单例
    static let s = CAProgressWidget()
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
    /// 动画时间，秒为单位
    let animateTime: Double = 0.2
    /// 控件展示类型
    var showModel: CAProgressWidgetModel = .Indeterminate

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
    
    func dismiss() -> Void{
		
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
		
        UIView.animateWithDuration(animateTime, animations: { () -> Void in
            self.alpha = CGFloat(0)
        }) { (isFininshed) -> Void in
                self.label?.text = nil
                self.detailLabel?.text = nil
                self.removeFromSuperview()
        }
    }
    
    func show(inView: UIView?, text: String?, detailText: String?) {

        //如果已经显示了，先隐藏
        if superview != nil{
            dismiss()
            sleep(UInt32(animateTime * 1000))
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
        }
                
        //显示
        UIView.animateWithDuration(animateTime, animations: { () -> Void in
            self.alpha = 1.0
            }, completion: { (finished) -> Void in
                self.progressView?.startAnimating()
                self.performSelector(Selector("dismiss"), withObject: nil, afterDelay: self.timeout)
        })
    }
	
	// MARK: - Class Methods
    
    /**
        展示加载框
    
        - parameter inView: 父视图
    */
    class func show(inView: UIView?) -> Void  {
        s.show(inView, text: nil, detailText: nil)
    }
	
    /**
        展示带标题的加载框
	
        - parameter superView: 父视图
        - parameter text:      标题内容
    */
    class func show(inView: UIView?, text:String?) -> Void {
        s.show(inView, text: text, detailText: nil)
    }
	
    /**
        展示带标题和描述的加载框
    
        - parameter superView:  父视图
        - parameter text:       标题内容
        - parameter detailText: 描述内容
    */
    class func show(inView: UIView?, text: String?, detailText: String?) {
        s.show(inView, text: text, detailText: detailText)
    }
	
    /**
        隐藏加载框
    */
    class func dismiss() -> Void {
        s.dismiss()
    }
}
