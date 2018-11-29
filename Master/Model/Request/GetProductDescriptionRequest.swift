//
//  GetProductDescription.swift
//  Master
//
//  Created by Gürsu Aşık on 7.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetProductDescriptionRequest {
    var endPoint = "/GetProductDescription"
    var method: HTTPMethod = .post
    
    var productCode:String = ""
    
    init(productCode: String) {
        self.productCode = productCode
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().PRODUCT + endPoint
    }
    
    func parameters() -> [String: Any] {
        var arr = [String: Any]()
        
        arr[RequestApi.ProductCode] = productCode
        
        return arr
    }
}
