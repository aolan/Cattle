//
//  Serializer.swift
//  cattle
//
//  Created by lawn on 15/11/9.
//  Copyright © 2015年 zodiac. All rights reserved.
//

import Alamofire

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}

extension Request {
    
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)

            switch result {
                case .Success(let value):
                    if let response = response, responseObject = T(response: response, representation: value){
                        return .Success(responseObject)
                    }else {
                        let failureReason = "JSON could not be serialized into response object: \(value)"
                        let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                        return .Failure(error)
                    }
                
                case .Failure(let error):
                    return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
