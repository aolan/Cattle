//
//  UIView+CAExtension.swift
//  cattle
//
//  Created by lawn on 15/11/6.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import UIKit

extension UIView{
    
    func removeAllSubViews() -> Void{
        for tmpView in subviews{
            tmpView.removeFromSuperview()
        }
    }
}