//
//  RegisterResult.swift
//  Master
//
//  Created by Gürsu Aşık on 17.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let registerResult = try? newJSONDecoder().decode(RegisterResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRegisterResult { response in
//     if let registerResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class RegisterResult: Codable {
    let success: Bool
    let message: String
    var data: RegisterDataClass? = nil
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: RegisterDataClass) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class RegisterDataClass: Codable {
    let uniqNo, name, surname, email: String
    let password, mobile: String
    let wantsNewsletter, isSMS, isConfirmSMS: Bool
    let id: Int
    let recordDate, gender: String
    let birthDay: RegisterJSONNull?
    let identityNumber, workingStatus: String
    let isUpdated, isValid: Bool
    let segments: [RegisterSegment]
    let facebookID: RegisterJSONNull?
    
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
    
    init(uniqNo: String, name: String, surname: String, email: String, password: String, mobile: String, wantsNewsletter: Bool, isSMS: Bool, isConfirmSMS: Bool, id: Int, recordDate: String, gender: String, birthDay: RegisterJSONNull?, identityNumber: String, workingStatus: String, isUpdated: Bool, isValid: Bool, segments: [RegisterSegment], facebookID: RegisterJSONNull?) {
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

class RegisterSegment: Codable {
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

class RegisterJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(RegisterJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func RegisterNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func RegisterNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try RegisterNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseRegisterResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<RegisterResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
