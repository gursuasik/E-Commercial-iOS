//
//  TokenRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 26.07.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class TokenRequest {
    var endPoint = "/token"
    var method: HTTPMethod = .post
    
    var grand_type: String = "password"
    var username: String = ""
    var password: String = ""
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func url() -> String {
        return Config().URL + endPoint
    }
    
    func parameters() -> [String: Any] {
        var arr = [String: Any]()
        
        arr[RequestApi.grand_type] = grand_type
        arr[RequestApi.username] = username
        arr[RequestApi.password] = password
        
        return arr
    }
}
