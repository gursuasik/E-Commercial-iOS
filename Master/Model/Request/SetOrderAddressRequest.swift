//
//  SetOrderAddressRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 3.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class SetOrderAddressRequest {
    var endPoint = "/SetOrderAddress"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var IsFastDelivery: Bool
    var InvoiceId: Int
    var UseDelivery: String
    
    init(token_type: String, authorization: String, IsFastDelivery: Bool, InvoiceId: Int, UseDelivery: String) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.IsFastDelivery = IsFastDelivery
        self.InvoiceId = InvoiceId
        self.UseDelivery = UseDelivery
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
        
        arr[RequestApi.isFastDelivery] = IsFastDelivery
        arr[RequestApi.invoiceId] = InvoiceId
        arr[RequestApi.useDelivery] = UseDelivery
        
        return arr
    }
}
