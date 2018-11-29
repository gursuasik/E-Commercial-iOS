//
//  SetOrderAddressResult.swift
//  Master
//
//  Created by Gürsu Aşık on 3.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let setOrderAddressResult = try? newJSONDecoder().decode(SetOrderAddressResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSetOrderAddressResult { response in
//     if let setOrderAddressResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class SetOrderAddressResult: Codable {
    let success: Bool
    let message: String
    let data: SetOrderAddressJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: SetOrderAddressJSONNull?) {
        self.success = success
        self.message = message
        self.data = data
    }
}

// MARK: Encode/decode helpers

class SetOrderAddressJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(SetOrderAddressJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func SetOrderAddressNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func SetOrderAddressNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try SetOrderAddressNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseSetOrderAddressResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SetOrderAddressResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

