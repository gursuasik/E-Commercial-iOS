//
//  DeleteProduct.swift
//  Master
//
//  Created by Gürsu Aşık on 29.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class DeleteProductRequest {
    var endPoint = "/deleteproduct"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var data: String
    
    init(token_type: String, authorization: String, data: String) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.data = data
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().ORDER + endPoint
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
