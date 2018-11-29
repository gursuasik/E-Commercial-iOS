//
//  GetTownListResult.swift
//  Master
//
//  Created by Gürsu Aşık on 11.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetTownListResult: Codable {
    let success: Bool
    let message: String
    let data: [GetTownListData]
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: [GetTownListData]) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetTownListData: Codable {
    let id, cityID: Int
    let name, integrationCode: String
    var cargoKey: String? = nil
    let reference1: GetTownListJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case cityID = "CityId"
        case name = "Name"
        case integrationCode = "IntegrationCode"
        case cargoKey = "CargoKey"
        case reference1 = "Reference1"
    }
    
    init(id: Int, cityID: Int, name: String, integrationCode: String, cargoKey: String? = nil, reference1: GetTownListJSONNull?) {
        self.id = id
        self.cityID = cityID
        self.name = name
        self.integrationCode = integrationCode
        self.cargoKey = cargoKey
        self.reference1 = reference1
    }
}

// MARK: Encode/decode helpers

class GetTownListJSONNull: Codable, Hashable {
    
    public static func == (lhs: GetTownListJSONNull, rhs: GetTownListJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetTownListJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func GetTownListNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetTownListNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetTownListNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetTownListResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetTownListResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
