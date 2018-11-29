//
//  GetTownListRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 11.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetTownListRequest {
    var endPoint = "/GetTownList"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var cityId: Int
    
    init(token_type: String, authorization: String, cityId: Int) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.cityId = cityId
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
        
        arr[RequestApi.CityId] = cityId
        
        return arr
    }
}
