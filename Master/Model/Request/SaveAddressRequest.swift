//
//  SaveAddressRequest.swift
//  Master
//
//  Created by Gürsu Aşık on 11.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class SaveAddressRequest {
    var endPoint = "/SaveAddress"
    var method: HTTPMethod = .post
    
    var token_type: String
    var authorization: String
    
    var type: Int
    var contactId: Int
    var nickName: String
    var name: String
    var surname: String
    var countryId: Int
    var cityId: Int
    var cityName: String
    var townId: Int
    var townName: String
    var areaId: String
    var apartmentNo: String
    var nearestArea: String
    var addressText: String
    var phone: String
    var taxNo: String
    var taxOffice: String
    var id: Int
    var identityNumber: String
    
    init(token_type: String, authorization: String, type: Int, contactId: Int, nickName: String, name: String, surname: String, countryId: Int, cityId: Int, cityName: String, townId: Int, townName: String, areaId: String, apartmentNo: String, nearestArea: String, addressText: String, phone: String, taxNo: String, taxOffice: String, id: Int, identityNumber: String) {
        self.token_type = token_type
        self.authorization = authorization
        
        self.type = type
        self.contactId = contactId
        self.nickName = nickName
        self.name = name
        self.surname = surname
        self.countryId = countryId
        self.cityId = cityId
        self.cityName = cityName
        self.townId = townId
        self.townName = townName
        self.areaId = areaId
        self.apartmentNo = apartmentNo
        self.nearestArea = nearestArea
        self.addressText = addressText
        self.phone = phone
        self.taxNo = taxNo
        self.taxOffice = taxOffice
        self.id = id
        self.identityNumber = identityNumber
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

        arr[RequestApi.type] = type
        arr[RequestApi.ContactId] = contactId
        arr[RequestApi.NickName] = nickName
        arr[RequestApi.Name] = name
        arr[RequestApi.Surname] = surname
        arr[RequestApi.CountryId] = countryId
        arr[RequestApi.CityId] = cityId
        arr[RequestApi.CityName] = cityName
        arr[RequestApi.TownId] = townId
        arr[RequestApi.TownName] = townName
        arr[RequestApi.AreaId] = areaId
        arr[RequestApi.ApartmentNo] = apartmentNo
        arr[RequestApi.NearestArea] = nearestArea
        arr[RequestApi.AddressText] = addressText
        arr[RequestApi.Phone] = phone
        arr[RequestApi.TaxNo] = taxNo
        arr[RequestApi.TaxOffice] = taxOffice
        arr[RequestApi.Id] = id
        arr[RequestApi.IdentityNumber] = identityNumber
        
        return arr
    }
}
