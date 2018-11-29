//
//  GetAreaListResult.swift
//  Master
//
//  Created by Gürsu Aşık on 12.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetAreaListResult: Codable {
    let success: Bool
    let message: String
    let data: [GetAreaListData]
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: [GetAreaListData]) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetAreaListData: Codable {
    let id, townID: Int
    let name: String
    let integrationCode, cargoOrderNumber: GetAreaListJSONNull?
    let cargoKey: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case townID = "TownId"
        case name = "Name"
        case integrationCode = "IntegrationCode"
        case cargoOrderNumber = "CargoOrderNumber"
        case cargoKey = "CargoKey"
    }
    
    init(id: Int, townID: Int, name: String, integrationCode: GetAreaListJSONNull?, cargoOrderNumber: GetAreaListJSONNull?, cargoKey: String) {
        self.id = id
        self.townID = townID
        self.name = name
        self.integrationCode = integrationCode
        self.cargoOrderNumber = cargoOrderNumber
        self.cargoKey = cargoKey
    }
}

// MARK: Encode/decode helpers

class GetAreaListJSONNull: Codable, Hashable {
    
    public static func == (lhs: GetAreaListJSONNull, rhs: GetAreaListJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetAreaListJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func GetAreaListNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetAreaListNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetAreaListNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetAreaListResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetAreaListResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
