//
//  AddProductRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 28.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class AddProductRequest {
    var endPoint = "/addproduct"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var barcode: String
    var isUpdate: String
    var isAddedBySnapBuy: Bool
    var quantity: String
    
    init(token_type: String, authorization: String, barcode: String, isUpdate: String, isAddedBySnapBuy: Bool, quantity: String) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.barcode = barcode
        self.isUpdate = isUpdate
        self.isAddedBySnapBuy = isAddedBySnapBuy
        self.quantity = quantity
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
        
        arr[RequestApi.Barcode] = barcode
        arr[RequestApi.IsUpdate] = isUpdate
        arr[RequestApi.IsAddedBySnapBuy] = isAddedBySnapBuy
        arr[RequestApi.Quantity] = quantity
        
        return arr
    }
}
