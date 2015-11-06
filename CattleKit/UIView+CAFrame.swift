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
	
	func ca_minX(x: CGFloat) -> Void{
		frame.origin.x = x
	}
	
	func ca_minY() -> CGFloat{
		return frame.origin.y
	}
	
	func ca_minY(y: CGFloat) -> Void{
		frame.origin.y = y
	}
	
	func ca_maxX() -> CGFloat{
		return frame.origin.x + frame.size.width
	}
	
	func ca_maxX(x:CGFloat) -> Void{
		frame.origin.x = x - frame.size.width
	}
	
	func ca_maxY() -> CGFloat{
		return frame.origin.y + frame.size.height
	}
	
	func ca_maxY(y:CGFloat) -> Void{
		frame.origin.y = y - frame.size.height
	}
	
	func ca_width() -> CGFloat{
		return frame.size.width
	}
	
	func ca_width(w:CGFloat) -> Void{
		frame.size.width = w
	}
	
	func ca_heigth() -> CGFloat{
		return frame.size.height
	}
	
	func ca_height(h:CGFloat) -> Void{
		frame.size.height = h
	}
	
	func ca_centerX() -> CGFloat{
		return frame.origin.x + frame.size.width/2.0
	}
	
	func ca_centerX(x:CGFloat) -> Void{
		frame.origin.x = x - frame.size.width/2.0
	}
	
	func ca_centerY() -> CGFloat{
		return frame.origin.y + frame.size.height/2.0
	}
	
	func ca_centerY(y:CGFloat) -> Void{
		frame.origin.y = y - frame.size.height/2.0
	}
	
	func ca_center() -> CGPoint{
		return CGPoint(x: ca_centerX(), y: ca_centerY())
	}
	
	func ca_center(p:CGPoint) ->Void{
		frame.origin.x = p.x - frame.size.width/2.0
		frame.origin.y = p.y - frame.size.height/2.0
	}
	
	func ca_size() -> CGSize{
		return frame.size
	}
	
	func ca_size(size:CGSize) -> Void{
		frame.size = size
	}
	
	func ca_addX(increment:CGFloat) -> Void{
		frame.origin.x += increment
	}
	
	func ca_addY(increment:CGFloat) -> Void{
		frame.origin.y += increment
	}
}
