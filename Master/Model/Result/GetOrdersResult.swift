//
//  GetOrdersResult.swift
//  Master
//
//  Created by Gürsu Aşık on 14.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetOrdersResult: Codable {
    let success: Bool
    let message: String
    let data: [GetOrdersData]
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: [GetOrdersData]) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetOrdersData: Codable {
    let saleCode, saleCreateDate, billLink, cargoLink: String
    let status: Int
    let extra: GetOrdersExtra
    let subGrandTotal, totalDiscount, totalCampaignDiscount, totalCouponDiscount: Double
    let grandTotal: Double
    let isCancel: Bool
    
    enum CodingKeys: String, CodingKey {
        case saleCode = "SaleCode"
        case saleCreateDate = "SaleCreateDate"
        case billLink = "BillLink"
        case cargoLink = "CargoLink"
        case status = "Status"
        case extra = "Extra"
        case subGrandTotal = "SubGrandTotal"
        case totalDiscount = "TotalDiscount"
        case totalCampaignDiscount = "TotalCampaignDiscount"
        case totalCouponDiscount = "TotalCouponDiscount"
        case grandTotal = "GrandTotal"
        case isCancel = "IsCancel"
    }
    
    init(saleCode: String, saleCreateDate: String, billLink: String, cargoLink: String, status: Int, extra: GetOrdersExtra, subGrandTotal: Double, totalDiscount: Double, totalCampaignDiscount: Double, totalCouponDiscount: Double, grandTotal: Double, isCancel: Bool) {
        self.saleCode = saleCode
        self.saleCreateDate = saleCreateDate
        self.billLink = billLink
        self.cargoLink = cargoLink
        self.status = status
        self.extra = extra
        self.subGrandTotal = subGrandTotal
        self.totalDiscount = totalDiscount
        self.totalCampaignDiscount = totalCampaignDiscount
        self.totalCouponDiscount = totalCouponDiscount
        self.grandTotal = grandTotal
        self.isCancel = isCancel
    }
}

class GetOrdersExtra: Codable {
    
    init() {
    }
}

func GetOrdersNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetOrdersNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetOrdersNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetOrdersResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetOrdersResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
