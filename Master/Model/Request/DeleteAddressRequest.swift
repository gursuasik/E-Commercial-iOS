//
//  DeleteAddressRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 13.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class DeleteAddressRequest {
    var endPoint = "/DeleteAddress"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var type: Int
    var id: Int

    init(token_type: String, authorization: String, type: Int, id: Int) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.type = type
        self.id = id
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
        arr[RequestApi.Id] = id
        
        return arr
    }
}
