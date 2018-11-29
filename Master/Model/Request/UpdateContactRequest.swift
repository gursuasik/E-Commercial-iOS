//
//  UpdateContactRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 24.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class UpdateContactRequest {
    var endPoint = "/updatecontact"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var id: Int
    var uniqNo: String
    var name: String
    var surname: String
    var email: String
    var password: String
    var gender: String
    var birthDay: String
    var mobile: String
    var wantsNewsletter: String
    var isValid: String
    var workingStatus: String
    var identityNumber: String
    
    init(token_type: String, authorization: String, id: Int, uniqNo: String, name: String, surname: String, email: String, password: String, gender: String, birthDay: String, mobile: String, wantsNewsletter: String, isValid: String, workingStatus: String, identityNumber: String) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.id = id
        self.uniqNo = uniqNo
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.gender = gender
        self.birthDay = birthDay
        self.mobile = mobile
        self.wantsNewsletter = wantsNewsletter
        self.isValid = isValid
        self.workingStatus = workingStatus
        self.identityNumber = identityNumber
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().CONTACT + endPoint
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
        
        arr[RequestApi.Id] = id
        arr[RequestApi.UniqNo] = uniqNo
        arr[RequestApi.Name] = name
        arr[RequestApi.Surname] = surname
        arr[RequestApi.Email] = email
        arr[RequestApi.Password] = password
        arr[RequestApi.Gender] = gender
        arr[RequestApi.BirthDay] = birthDay
        arr[RequestApi.Mobile] = mobile
        arr[RequestApi.WantsNewsletter] = wantsNewsletter
        arr[RequestApi.IsValid] = isValid
        arr[RequestApi.WorkingStatus] = workingStatus
        arr[RequestApi.IdentityNumber] = identityNumber
        
        return arr
    }
}
