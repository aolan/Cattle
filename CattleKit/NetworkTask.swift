//
//  NetworkTask.swift
//  cattle
//
//  Created by lawn on 15/10/29.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

public class NetworkTask: NSObject{
	
	// MARK:- Property Define
	public enum HttpMethod{ case GET, POST, PUT, DELETE}
	var requestSignedKey:String = "sign"
	
	// MARK:- Public Methods
	public func startRequest() -> Void{
		
		switch requestMethod(){
			case .GET:
				GETRequest()
			case .POST:
				POSTRequest()
			case .PUT:
				PUTRequest()
			case .DELETE:
				DELETERequest()
		}
	}
	
	// MARK:- Override by SubClass
	public func responseModelClass() ->String{
		return "ResponseModel"
	}
	
	public func requestProtocol() ->String{
		return "http://"
	}
	
	public func requestHost() ->String{
		return "apis.baidu.com"
	}
	
	public func requestPath() ->String{
		return ""
	}
	
	public func requestHeaders() ->[String:String]{
		return [String:String]()
	}
	
	public func requestBody() ->[String:AnyObject]?{
		
		var tmpRequestBody:Dictionary? = [String:AnyObject]()
		let properties = propertyNames()
		
		for propertyName in properties{
			if self.valueForKey(propertyName) != nil{
				tmpRequestBody?[propertyName] = self.valueForKey(propertyName)
			}
		}
		
		let signString:String? = requestSign()
		if signString != nil{
			tmpRequestBody?[requestSignedKey] = signString!
		}
		
		return tmpRequestBody
	}
	
	public func requestSign() ->String?{
		return nil
	}
	
	public func requestMethod() -> HttpMethod{
		return .GET
	}
	
	
	// MARK:- Private Methods
	private func GETRequest() -> Void{
		
		Alamofire.request(.GET, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseJSON { (response) -> Void in
			
			print(response.response)
			if let JSON = response.result.value {
				print("JSON: \(JSON)")
			}
		}
	}
	
	private func POSTRequest() -> Void{
		
		Alamofire.request(.POST, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseJSON { (response) -> Void in
			
			print(response.response)
			if let JSON = response.result.value {
				print("JSON: \(JSON)")
			}
		}
	}
	
	private func PUTRequest() -> Void{
		
		Alamofire.request(.PUT, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseJSON { (response) -> Void in
			
			print(response.response)
			if let JSON = response.result.value {
				print("JSON: \(JSON)")
			}
		}
	}
	
	private func DELETERequest() -> Void{
		
		Alamofire.request(.DELETE, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseJSON { (response) -> Void in
			
			print(response.response)
			if let JSON = response.result.value {
				print("JSON: \(JSON)")
			}
		}
	}
	
	private func getUrl() ->String{
		return requestProtocol() + requestHost() + "/" + requestPath()
	}
}

