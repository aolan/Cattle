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

/// 网络请求类，接口继承该类，重写部分方法后，调用startRequest方法即可
public class NetworkTask: NSObject{
	
    // MARK:- Property Define
    
    public enum HttpMethod:String{ case GET, POST, PUT, DELETE}
    var requestSignedKey:String = "sign"
	
    // MARK:- Public Methods
	
    /**
        发送请求
    */
    public func startRequest<T:ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Void{
		
        switch requestMethod(){
            case .GET:
                GETRequest(completionHandler)
            case .POST:
                POSTRequest(completionHandler)
            case .PUT:
                PUTRequest(completionHandler)
            case .DELETE:
                DELETERequest(completionHandler)
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
    
    /**
        发送Get请求
    
        - parameter completionHandler: 回调闭包
    */
    private func GETRequest<T:ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Void{
        Alamofire.request(.GET, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseObject { (response:Response<T, NSError>) -> Void in
            completionHandler(response)
        }
    }
	
    /**
        发送POST请求
    
        - parameter completionHandler: 回调闭包
    */
    private func POSTRequest<T:ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Void{
		
        Alamofire.request(.POST, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseObject { (response:Response<T, NSError>) -> Void in
            completionHandler(response)
        }
    }
	
    /**
        发送PUT请求
    
        - parameter completionHandler: 回调闭包
    */
    private func PUTRequest<T:ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Void{
		
        Alamofire.request(.PUT, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseObject { (response:Response<T, NSError>) -> Void in
            completionHandler(response)
        }
    }
	
    /**
    发送DELETE请求
    
    - parameter completionHandler: 回调闭包
    */
    private func DELETERequest<T:ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Void{
		
        Alamofire.request(.DELETE, getUrl(), parameters: requestBody(), encoding: .URL, headers: requestHeaders()).responseObject { (response:Response<T, NSError>) -> Void in
            completionHandler(response)
        }
    }
	
    /**
        获取请求URL
    
        - returns: 返回请求URL
    */
    private func getUrl() -> String{
        return requestProtocol() + requestHost() + "/" + requestPath()
    }
    
    
    /**
        将JSON解析成model对象
    
        - parameter json: JSON字典
    
        - returns: 解析是否成功
    */
    private func parseJsonToModel(json: NSDictionary?) -> Bool{
     
        if json != nil {
            
            let jsonBody = (json?.objectForKey("HeWeather data service 3.0"))!
            debugPrint(jsonBody)
            
            return true
        }
        
        return false
    }
}

