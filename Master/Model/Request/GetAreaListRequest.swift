//
//  GetAreaListRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 12.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetAreaListRequest {
    var endPoint = "/GetAreaList"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var data: Int
    
    init(token_type: String, authorization: String, Data: Int) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.data = Data
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
        
        arr[RequestApi.Data] = data
        
        return arr
    }
}
