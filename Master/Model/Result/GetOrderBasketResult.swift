//
//  GetOrderBasketResult.swift
//  Master
//
//  Created by Gürsu Aşık on 28.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetOrderBasketResult: Codable {
    let success: Bool
    let message: String
    let data: GetOrderBasketDataClass
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: GetOrderBasketDataClass) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetOrderBasketDataClass: Codable {
    let id: Int
    let dateTimeNow, saleCode: String
    let isBasket, isCancel, isValid, isStore: Bool
    let addresses: [GetOrderBasketJSONAny]
    let details: [GetOrderBasketDataDetail]
    let groupDetails: [GetOrderBasketJSONAny]
    let payments: [GetOrderBasketPayment]
    let fields, discounts: [GetOrderBasketJSONAny]
    let basketCreateDate: String
    let saleCreateDate: GetOrderBasketJSONNull?
    let status: Int
    let saleNote: GetOrderBasketJSONNull?
    let giftNote: String
    var cargoLink: String? = nil
    let subGrandTotal, subGrandTotalWithoutCargo, subGrandTotalWithProductDiscounts, grandTotal, grandTotalWithoutCargo, totalProductDiscount, totalCouponDiscount, totalCampaignDiscount: Double
    let totalCargo, totalPayment: Int
    let totalVat, totalDiscount, remainingPrice, remaningFreeCargoPrice, freeCargoPrice: Double
    let basketCargoMessage: String
    let isGiftBox: Bool
    let refundGrandTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case dateTimeNow = "DateTimeNow"
        case saleCode = "SaleCode"
        case isBasket = "IsBasket"
        case isCancel = "IsCancel"
        case isValid = "IsValid"
        case isStore = "IsStore"
        case addresses = "Addresses"
        case details = "Details"
        case groupDetails = "GroupDetails"
        case payments = "Payments"
        case fields = "Fields"
        case discounts = "Discounts"
        case basketCreateDate = "BasketCreateDate"
        case saleCreateDate = "SaleCreateDate"
        case status = "Status"
        case saleNote = "SaleNote"
        case giftNote = "GiftNote"
        case cargoLink = "CargoLink"
        case subGrandTotal = "SubGrandTotal"
        case subGrandTotalWithoutCargo = "SubGrandTotalWithoutCargo"
        case subGrandTotalWithProductDiscounts = "SubGrandTotalWithProductDiscounts"
        case grandTotal = "GrandTotal"
        case grandTotalWithoutCargo = "GrandTotalWithoutCargo"
        case totalProductDiscount = "TotalProductDiscount"
        case totalCouponDiscount = "TotalCouponDiscount"
        case totalCampaignDiscount = "TotalCampaignDiscount"
        case totalCargo = "TotalCargo"
        case totalPayment = "TotalPayment"
        case totalVat = "TotalVat"
        case totalDiscount = "TotalDiscount"
        case remainingPrice = "RemainingPrice"
        case remaningFreeCargoPrice = "RemaningFreeCargoPrice"
        case freeCargoPrice = "FreeCargoPrice"
        case basketCargoMessage = "BasketCargoMessage"
        case isGiftBox = "IsGiftBox"
        case refundGrandTotal = "RefundGrandTotal"
    }
    
    init(id: Int, dateTimeNow: String, saleCode: String, isBasket: Bool, isCancel: Bool, isValid: Bool, isStore: Bool, addresses: [GetOrderBasketJSONAny], details: [GetOrderBasketDataDetail], groupDetails: [GetOrderBasketJSONAny], payments: [GetOrderBasketPayment], fields: [GetOrderBasketJSONAny], discounts: [GetOrderBasketJSONAny], basketCreateDate: String, saleCreateDate: GetOrderBasketJSONNull?, status: Int, saleNote: GetOrderBasketJSONNull?, giftNote: String, cargoLink: String? = nil, subGrandTotal: Double, subGrandTotalWithoutCargo: Double, subGrandTotalWithProductDiscounts: Double, grandTotal: Double, grandTotalWithoutCargo: Double, totalProductDiscount: Double, totalCouponDiscount: Double, totalCampaignDiscount: Double, totalCargo: Int, totalPayment: Int, totalVat: Double, totalDiscount: Double, remainingPrice: Double, remaningFreeCargoPrice: Double, freeCargoPrice: Double, basketCargoMessage: String, isGiftBox: Bool, refundGrandTotal: Int) {
        self.id = id
        self.dateTimeNow = dateTimeNow
        self.saleCode = saleCode
        self.isBasket = isBasket
        self.isCancel = isCancel
        self.isValid = isValid
        self.isStore = isStore
        self.addresses = addresses
        self.details = details
        self.groupDetails = groupDetails
        self.payments = payments
        self.fields = fields
        self.discounts = discounts
        self.basketCreateDate = basketCreateDate
        self.saleCreateDate = saleCreateDate
        self.status = status
        self.saleNote = saleNote
        self.giftNote = giftNote
        self.cargoLink = cargoLink
        self.subGrandTotal = subGrandTotal
        self.subGrandTotalWithoutCargo = subGrandTotalWithoutCargo
        self.subGrandTotalWithProductDiscounts = subGrandTotalWithProductDiscounts
        self.grandTotal = grandTotal
        self.grandTotalWithoutCargo = grandTotalWithoutCargo
        self.totalProductDiscount = totalProductDiscount
        self.totalCouponDiscount = totalCouponDiscount
        self.totalCampaignDiscount = totalCampaignDiscount
        self.totalCargo = totalCargo
        self.totalPayment = totalPayment
        self.totalVat = totalVat
        self.totalDiscount = totalDiscount
        self.remainingPrice = remainingPrice
        self.remaningFreeCargoPrice = remaningFreeCargoPrice
        self.freeCargoPrice = freeCargoPrice
        self.basketCargoMessage = basketCargoMessage
        self.isGiftBox = isGiftBox
        self.refundGrandTotal = refundGrandTotal
    }
}

class GetOrderBasketDataDetail: Codable {
    let productID, productDescriptionID: Int
    let uniqNo: String
    let quantity: Int
    let oldPrice, price: Double
    let barcode, code: String
    let status: Int
    let body, color: String
    let vatRatio: Int
    let vatTotal: Double
    let name: String
    let isOtherProduct, isCargo: Bool
    let discount, productDiscount, salePrice: Double
    let giftNote: GetOrderBasketJSONNull?
    let mark: String
    let isGiftBox: Bool
    let image: GetOrderBasketJSONNull?
    let imagePath: String
    let orderDetailFields: [GetOrderBasketJSONAny]
    
    enum CodingKeys: String, CodingKey {
        case productID = "ProductId"
        case productDescriptionID = "ProductDescriptionId"
        case uniqNo = "UniqNo"
        case quantity = "Quantity"
        case oldPrice = "OldPrice"
        case price = "Price"
        case barcode = "Barcode"
        case code = "Code"
        case status = "Status"
        case body = "Body"
        case color = "Color"
        case vatRatio = "VatRatio"
        case vatTotal = "VatTotal"
        case name = "Name"
        case isOtherProduct = "IsOtherProduct"
        case isCargo = "IsCargo"
        case discount = "Discount"
        case productDiscount = "ProductDiscount"
        case salePrice = "SalePrice"
        case giftNote = "GiftNote"
        case mark = "Mark"
        case isGiftBox = "IsGiftBox"
        case image = "Image"
        case imagePath = "ImagePath"
        case orderDetailFields = "OrderDetailFields"
    }
    
    init(productID: Int, productDescriptionID: Int, uniqNo: String, quantity: Int, oldPrice: Double, price: Double, barcode: String, code: String, status: Int, body: String, color: String, vatRatio: Int, vatTotal: Double, name: String, isOtherProduct: Bool, isCargo: Bool, discount: Double, productDiscount: Double, salePrice: Double, giftNote: GetOrderBasketJSONNull?, mark: String, isGiftBox: Bool, image: GetOrderBasketJSONNull?, imagePath: String, orderDetailFields: [GetOrderBasketJSONAny]) {
        self.productID = productID
        self.productDescriptionID = productDescriptionID
        self.uniqNo = uniqNo
        self.quantity = quantity
        self.oldPrice = oldPrice
        self.price = price
        self.barcode = barcode
        self.code = code
        self.status = status
        self.body = body
        self.color = color
        self.vatRatio = vatRatio
        self.vatTotal = vatTotal
        self.name = name
        self.isOtherProduct = isOtherProduct
        self.isCargo = isCargo
        self.discount = discount
        self.productDiscount = productDiscount
        self.salePrice = salePrice
        self.giftNote = giftNote
        self.mark = mark
        self.isGiftBox = isGiftBox
        self.image = image
        self.imagePath = imagePath
        self.orderDetailFields = orderDetailFields
    }
}

class GetOrderBasketPayment: Codable {
    let details: [GetOrderBasketPaymentDetail]
    let isDiscount: Bool
    let couponCode: String
    let totalPrice: Int
    let bankName: GetOrderBasketJSONNull?
    let paymentTypeName, recordDate: String
    let installment: GetOrderBasketJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case details = "Details"
        case isDiscount = "IsDiscount"
        case couponCode = "CouponCode"
        case totalPrice = "TotalPrice"
        case bankName = "BankName"
        case paymentTypeName = "PaymentTypeName"
        case recordDate = "RecordDate"
        case installment = "Installment"
    }
    
    init(details: [GetOrderBasketPaymentDetail], isDiscount: Bool, couponCode: String, totalPrice: Int, bankName: GetOrderBasketJSONNull?, paymentTypeName: String, recordDate: String, installment: GetOrderBasketJSONNull?) {
        self.details = details
        self.isDiscount = isDiscount
        self.couponCode = couponCode
        self.totalPrice = totalPrice
        self.bankName = bankName
        self.paymentTypeName = paymentTypeName
        self.recordDate = recordDate
        self.installment = installment
    }
}

class GetOrderBasketPaymentDetail: Codable {
    let detailUniqNo: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case detailUniqNo = "DetailUniqNo"
        case price = "Price"
    }
    
    init(detailUniqNo: String, price: Int) {
        self.detailUniqNo = detailUniqNo
        self.price = price
    }
}

// MARK: Encode/decode helpers

class GetOrderBasketJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetOrderBasketJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSON1Null"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class GetOrderBasketJSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class GetOrderBasketJSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(GetOrderBasketJSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return GetOrderBasketJSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return GetOrderBasketJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: GetOrderBasketJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<GetOrderBasketJSONCodingKey>, forKey key: GetOrderBasketJSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return GetOrderBasketJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: GetOrderBasketJSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<GetOrderBasketJSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is GetOrderBasketJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: GetOrderBasketJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<GetOrderBasketJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = GetOrderBasketJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is GetOrderBasketJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: GetOrderBasketJSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is GetOrderBasketJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try GetOrderBasketJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: GetOrderBasketJSONCodingKey.self) {
            self.value = try GetOrderBasketJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try GetOrderBasketJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try GetOrderBasketJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: GetOrderBasketJSONCodingKey.self)
            try GetOrderBasketJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try GetOrderBasketJSONAny.encode(to: &container, value: self.value)
        }
    }
}

func GetOrderBasketNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetOrderBasketNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetOrderBasketNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetOrderBasketResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetOrderBasketResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
