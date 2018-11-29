//
//  HomePageRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 6.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class HomePageRequest {
    var endPoint = "/homepage"
    var method: HTTPMethod = .get

    init() {

    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().PAGE + endPoint
    }
    
    func parameters() -> [String: Any] {
        var arr = [String: Any]()
        
        return arr
    }
}
