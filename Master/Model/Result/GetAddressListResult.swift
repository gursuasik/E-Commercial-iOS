//
//  GetAddressListResult.swift
//  Master
//
//  Created by Gürsu Aşık on 31.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let getAddressListResult = try? newJSONDecoder().decode(GetAddressListResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGetAddressListResult { response in
//     if let getAddressListResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class GetAddressListResult: Codable {
    let success: Bool
    let message: String
    let data: [GetAddressListData]
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: [GetAddressListData]) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetAddressListData: Codable {
    let id, type, contactID, countryID: Int
    let cityID: Int
    let cityName: String
    let townID: Int
    let townName: String
    var areaID: Int? = nil
    var areaName: String? = nil
    let addressText, name, surname: String
    let nickName: String
    var taxOffice: String? = nil
    var taxNo: String? = nil
    let phone: String
    var identityNumber: String? = nil
    let recordDate: String
    var apartmentNo: String? = nil
    let nearestArea, postCode: GetAddressListJSONNull?
    var receiver: String? = nil
    let region: GetAddressListJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case contactID = "ContactId"
        case countryID = "CountryId"
        case cityID = "CityId"
        case cityName = "CityName"
        case townID = "TownId"
        case townName = "TownName"
        case areaID = "AreaId"
        case areaName = "AreaName"
        case addressText = "AddressText"
        case name = "Name"
        case surname = "Surname"
        case nickName = "NickName"
        case taxOffice = "TaxOffice"
        case taxNo = "TaxNo"
        case phone = "Phone"
        case identityNumber = "IdentityNumber"
        case recordDate = "RecordDate"
        case apartmentNo = "ApartmentNo"
        case nearestArea = "NearestArea"
        case postCode = "PostCode"
        case receiver = "Receiver"
        case region = "Region"
    }
    
    init(id: Int, type: Int, contactID: Int, countryID: Int, cityID: Int, cityName: String, townID: Int, townName: String, areaID: Int? = nil, areaName: String? = nil, addressText: String, name: String, surname: String, nickName: String, taxOffice: String? = nil, taxNo: String? = nil, phone: String, identityNumber: String? = nil, recordDate: String, apartmentNo: String? = nil, nearestArea: GetAddressListJSONNull?, postCode: GetAddressListJSONNull?, receiver: String? = nil, region: GetAddressListJSONNull?) {
        self.id = id
        self.type = type
        self.contactID = contactID
        self.countryID = countryID
        self.cityID = cityID
        self.cityName = cityName
        self.townID = townID
        self.townName = townName
        self.areaID = areaID
        self.areaName = areaName
        self.addressText = addressText
        self.name = name
        self.surname = surname
        self.nickName = nickName
        self.taxOffice = taxOffice
        self.taxNo = taxNo
        self.phone = phone
        self.identityNumber = identityNumber
        self.recordDate = recordDate
        self.apartmentNo = apartmentNo
        self.nearestArea = nearestArea
        self.postCode = postCode
        self.receiver = receiver!
        self.region = region
    }
}

// MARK: Encode/decode helpers

class GetAddressListJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetAddressListJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func GetAddressListNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetAddressListNewJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try GetAddressListNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetAddressListResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetAddressListResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

