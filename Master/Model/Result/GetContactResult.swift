//
//  GetContactResult.swift
//  Master
//
//  Created by Gürsu Aşık on 11.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let getContactResult = try? newJSONDecoder().decode(GetContactResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGetContactResult { response in
//     if let getContactResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class GetContactResult: Codable {
    let success: Bool
    let message: String
    let data: GetContactDataClass
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: GetContactDataClass) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetContactDataClass: Codable {
    let uniqNo, name, surname, email: String
    let password, mobile: String
    let wantsNewsletter, isSMS, isConfirmSMS: Bool
    let id: Int
    let recordDate, gender, birthDay, identityNumber: String
    let workingStatus: String
    let isUpdated, isValid: Bool
    let segments: [GetContactSegment]
    let facebookID: GetContactJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case uniqNo = "UniqNo"
        case name = "Name"
        case surname = "Surname"
        case email = "Email"
        case password = "Password"
        case mobile = "Mobile"
        case wantsNewsletter = "WantsNewsletter"
        case isSMS = "IsSms"
        case isConfirmSMS = "IsConfirmSms"
        case id = "Id"
        case recordDate = "RecordDate"
        case gender = "Gender"
        case birthDay = "BirthDay"
        case identityNumber = "IdentityNumber"
        case workingStatus = "WorkingStatus"
        case isUpdated = "IsUpdated"
        case isValid = "IsValid"
        case segments = "Segments"
        case facebookID = "FacebookId"
    }
    
    init(uniqNo: String, name: String, surname: String, email: String, password: String, mobile: String, wantsNewsletter: Bool, isSMS: Bool, isConfirmSMS: Bool, id: Int, recordDate: String, gender: String, birthDay: String, identityNumber: String, workingStatus: String, isUpdated: Bool, isValid: Bool, segments: [GetContactSegment], facebookID: GetContactJSONNull?) {
        self.uniqNo = uniqNo
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.mobile = mobile
        self.wantsNewsletter = wantsNewsletter
        self.isSMS = isSMS
        self.isConfirmSMS = isConfirmSMS
        self.id = id
        self.recordDate = recordDate
        self.gender = gender
        self.birthDay = birthDay
        self.identityNumber = identityNumber
        self.workingStatus = workingStatus
        self.isUpdated = isUpdated
        self.isValid = isValid
        self.segments = segments
        self.facebookID = facebookID
    }
}

class GetContactSegment: Codable {
    let id, contactID: Int
    let name, value: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case contactID = "ContactId"
        case name = "Name"
        case value = "Value"
    }
    
    init(id: Int, contactID: Int, name: String, value: String) {
        self.id = id
        self.contactID = contactID
        self.name = name
        self.value = value
    }
}

// MARK: Encode/decode helpers

class GetContactJSONNull: Codable, Hashable {
    
    public static func == (lhs: GetContactJSONNull, rhs: GetContactJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetContactJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func GetContactNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetContactNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetContactNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetContactResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetContactResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
