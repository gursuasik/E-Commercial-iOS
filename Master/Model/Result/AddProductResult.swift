//
//  AddProductResult.swift
//  Master
//
//  Created by Gürsu Aşık on 29.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let addProductResult = try? newJSONDecoder().decode(AddProductResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAddProductResult { response in
//     if let addProductResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class AddProductResult: Codable {
    let success: Bool
    let message: String
    let data: AddProductDataClass
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: AddProductDataClass) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class AddProductDataClass: Codable {
    let data1, data2: String
    let data3, data4, data5: AddProductJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case data1 = "Data1"
        case data2 = "Data2"
        case data3 = "Data3"
        case data4 = "Data4"
        case data5 = "Data5"
    }
    
    init(data1: String, data2: String, data3: AddProductJSONNull?, data4: AddProductJSONNull?, data5: AddProductJSONNull?) {
        self.data1 = data1
        self.data2 = data2
        self.data3 = data3
        self.data4 = data4
        self.data5 = data5
    }
}

// MARK: Encode/decode helpers

class AddProductJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(AddProductJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func AddProductNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func AddProductNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try AddProductNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseAddProductResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<AddProductResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
