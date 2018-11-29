//
//  Register.swift
//  Master
//
//  Created by Gürsu Aşık on 17.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class RegisterRequest {
    var endPoint = "/register"
    var method: HTTPMethod = .post
    
    var name: String
    var surname: String
    var email: String
    var password: String
    var gender: String
    var birthDay: String
    var mobile: String
    var wantsNewsletter: String
    var isValid: String
    var iWantCard: String
    
    init(name: String, surname: String, email: String, password: String, gender: String, birthDay: String, mobile: String, wantsNewsletter: String, isValid: String, iWantCard: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.gender = gender
        self.birthDay = birthDay
        self.mobile = mobile
        self.wantsNewsletter = wantsNewsletter
        self.isValid = isValid
        self.iWantCard = iWantCard
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().MEMBER + endPoint
    }
    
    func parameters() -> [String: Any] {
        var arr = [String: Any]()
        
        arr[RequestApi.Name] = name
        arr[RequestApi.Surname] = surname
        arr[RequestApi.Email] = email
        arr[RequestApi.Password] = password
        arr[RequestApi.Gender] = gender
        arr[RequestApi.BirthDay] = birthDay
        arr[RequestApi.Mobile] = mobile
        arr[RequestApi.WantsNewsletter] = wantsNewsletter
        arr[RequestApi.IsValid] = isValid
        arr[RequestApi.IWantCard] = iWantCard
        
        return arr
    }
}
