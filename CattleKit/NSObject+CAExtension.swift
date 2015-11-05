//
//  NSObject+CAExtension.swift
//  cattle
//
//  Created by lawn on 15/11/5.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import Foundation

extension NSObject{
	
	public func propertyNames() -> Array<String> {
		
		var results: Array<String> = [];
		
		// retrieve the properties via the class_copyPropertyList function
		var count: UInt32 = 0;
		let myClass: AnyClass = self.classForCoder;
		let properties = class_copyPropertyList(myClass, &count);
		
		// iterate each objc_property_t struct
		for var i: UInt32 = 0; i < count; i++ {
			let property = properties[Int(i)];
			
			// retrieve the property name by calling property_getName function
			let cname = property_getName(property);
			
			// covert the c string into a Swift string
			let name = String.fromCString(cname);
			results.append(name!);
		}
		
		// release objc_property_t structs
		free(properties);
		
		return results;
	}
}
