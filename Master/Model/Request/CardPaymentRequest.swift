//
//  CardPaymentRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 4.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class CardPaymentRequest {
    var endPoint = "/CardPayment"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var email: String
    var name: String
    var cardNo: String
    var expireMonth: String
    var expireYear: String
    var cvv2: String
    var ip: String
    var installmentCount: Int
    
    init(token_type: String, authorization: String, email: String, name: String, cardNo: String, expireMonth: String, expireYear: String, cvv2: String, ip: String, installmentCount: Int) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.email = email
        self.name = name
        self.cardNo = cardNo
        self.expireMonth = expireMonth
        self.expireYear = expireYear
        self.cvv2 = cvv2
        self.ip = ip
        self.installmentCount = installmentCount
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
        var arr0 = [String: Any]()
        
        arr0[RequestApi.Cvv2] = cvv2
        arr0[RequestApi.Email] = email
        arr0[RequestApi.ExpireYear] = expireYear
        arr0[RequestApi.Name] = name
        arr0[RequestApi.Ip] = ip
        arr0[RequestApi.ExpireMonth] = expireMonth
        arr0[RequestApi.CardNo] = cardNo
        
        arr[RequestApi.CreditCard] = arr0
        arr[RequestApi.InstallmentCount] = installmentCount
        
        return arr
    }
}
