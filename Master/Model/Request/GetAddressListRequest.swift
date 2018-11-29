//
//  GetAddressList.swift
//  Master
//
//  Created by Gürsu Aşık on 31.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetAddressListRequest {
    var endPoint = "/GetAddressList"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var type: Int
    
    init(token_type: String, authorization: String, type: Int) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.type = type
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().ADDRESS + endPoint
    }
    
    func getHeaders() -> HTTPHeaders? {
        let headers: HTTPHeaders = [
            "Authorization": token_type + " " + authorization,
            "Accept": "application/json"
        ]
        
        return headers
    }
    
    func getParameters() -> [String: Any] {
        var arr = [String: Any]()
        
        arr[RequestApi.type] = type
        
        return arr
    }
}
