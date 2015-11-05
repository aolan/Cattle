//
//  UIView+CAFrame.swift
//  cattle
//
//  Created by lawn on 15/11/5.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import UIKit

extension UIView{
	
	func ca_minX() -> CGFloat{
		return frame.origin.x
	}
	
	func ca_minY() -> CGFloat{
		return frame.origin.y
	}
	
	func ca_maxX() -> CGFloat{
		return frame.origin.x + frame.size.width
	}
	
	func ca_maxY() -> CGFloat{
		return frame.origin.y + frame.size.height
	}
	
	func ca_width() -> CGFloat{
		return frame.size.width
	}
	
	func ca_heigth() -> CGFloat{
		return frame.size.height
	}
	
	func ca_centerX() -> CGFloat{
		return frame.origin.x + frame.size.width/2.0
	}
	
	func ca_centerY() -> CGFloat{
		return frame.origin.y + frame.size.height/2.0
	}
	
	func ca_center() -> CGPoint{
		return CGPoint(x: ca_centerX(), y: ca_centerY())
	}
}
