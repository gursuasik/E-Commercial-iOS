//
//  FastDeliveryRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 4.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class FastDeliveryIdsRequest {
    var endPoint = "/GetFastDeliveryIds"
    var method: HTTPMethod = .get
    
    var token_type: String
    var authorization: String
    
    init(token_type: String, authorization: String) {
        self.token_type = token_type
        self.authorization = authorization
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().VARIABLES + endPoint
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
                
        return arr
    }
}
