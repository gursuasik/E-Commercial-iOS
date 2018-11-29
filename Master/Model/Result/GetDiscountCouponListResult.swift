//
//  GetDiscountCouponListResult.swift
//  Master
//
//  Created by Gürsu Aşık on 24.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetDiscountCouponListResult: Codable {
    let success: Bool
    let message: String
    let data: [GetDiscountCouponListData]
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: [GetDiscountCouponListData]) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetDiscountCouponListData: Codable {
    let code: String
    let contactID: Int
    let description: String?
    let discountPrice: Double
    let discountRate: Int?
    let endDate, startDate, recordDate: String
    let isApplyCampaign, isDiscountIsCoupon: Bool
    let maxRequiredSaleAmount: JSONNull?
    let minRequiredSaleAmount, maxUserUseCount: Int
    let type: String
    let useCount, usedCount: Int
    let couponType: String
    let isValid: Bool
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case contactID = "ContactId"
        case description = "Description"
        case discountPrice = "DiscountPrice"
        case discountRate = "DiscountRate"
        case endDate = "EndDate"
        case startDate = "StartDate"
        case recordDate = "RecordDate"
        case isApplyCampaign = "IsApplyCampaign"
        case isDiscountIsCoupon = "IsDiscountIsCoupon"
        case maxRequiredSaleAmount = "MaxRequiredSaleAmount"
        case minRequiredSaleAmount = "MinRequiredSaleAmount"
        case maxUserUseCount = "MaxUserUseCount"
        case type = "Type"
        case useCount = "UseCount"
        case usedCount = "UsedCount"
        case couponType = "CouponType"
        case isValid = "IsValid"
    }
    
    init(code: String, contactID: Int, description: String?, discountPrice: Double, discountRate: Int?, endDate: String, startDate: String, recordDate: String, isApplyCampaign: Bool, isDiscountIsCoupon: Bool, maxRequiredSaleAmount: JSONNull?, minRequiredSaleAmount: Int, maxUserUseCount: Int, type: String, useCount: Int, usedCount: Int, couponType: String, isValid: Bool) {
        self.code = code
        self.contactID = contactID
        self.description = description
        self.discountPrice = discountPrice
        self.discountRate = discountRate
        self.endDate = endDate
        self.startDate = startDate
        self.recordDate = recordDate
        self.isApplyCampaign = isApplyCampaign
        self.isDiscountIsCoupon = isDiscountIsCoupon
        self.maxRequiredSaleAmount = maxRequiredSaleAmount
        self.minRequiredSaleAmount = minRequiredSaleAmount
        self.maxUserUseCount = maxUserUseCount
        self.type = type
        self.useCount = useCount
        self.usedCount = usedCount
        self.couponType = couponType
        self.isValid = isValid
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func GetDiscountCouponListNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetDiscountCouponListNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetDiscountCouponListNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetDiscountCouponListResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetDiscountCouponListResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
