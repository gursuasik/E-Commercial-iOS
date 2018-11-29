//
//  GetOrderResult.swift
//  Master
//
//  Created by Gürsu Aşık on 17.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class GetOrderResult: Codable {
    let success: Bool
    let message: String
    let data: GetOrderData
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: GetOrderData) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetOrderData: Codable {
    let id: Int
    let dateTimeNow, saleCode: String
    let isBasket, isCancel, isValid, isStore: Bool
    let addresses: [Address]
    let details: [DataDetail]
    let groupDetails: [JSONAny]
    let payments: [Payment]
    let fields: [Field]
    let discounts: [JSONAny]
    let basketCreateDate, saleCreateDate: String
    let status: Int
    var saleNote: String? = nil
    let giftNote, cargoLink: String
    let subGrandTotal, subGrandTotalWithoutCargo: Int
    let subGrandTotalWithProductDiscounts: Double
    let grandTotal: Double
    let grandTotalWithoutCargo, totalProductDiscount, totalCouponDiscount, totalCampaignDiscount: Int
    let totalCargo, totalPayment: Int
    let totalVat: Double
    let totalDiscount: Double
    let remainingPrice, remaningFreeCargoPrice, freeCargoPrice: Int
    let basketCargoMessage: String
    var couponCode: String? = nil
    let isGiftBox: Bool
    let refundGrandTotal: Double
    
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
        case couponCode = "CouponCode"
        case isGiftBox = "IsGiftBox"
        case refundGrandTotal = "RefundGrandTotal"
    }
    
    init(id: Int, dateTimeNow: String, saleCode: String, isBasket: Bool, isCancel: Bool, isValid: Bool, isStore: Bool, addresses: [Address], details: [DataDetail], groupDetails: [JSONAny], payments: [Payment], fields: [Field], discounts: [JSONAny], basketCreateDate: String, saleCreateDate: String, status: Int, saleNote: String, giftNote: String, cargoLink: String, subGrandTotal: Int, subGrandTotalWithoutCargo: Int, subGrandTotalWithProductDiscounts: Double, grandTotal: Double, grandTotalWithoutCargo: Int, totalProductDiscount: Int, totalCouponDiscount: Int, totalCampaignDiscount: Int, totalCargo: Int, totalPayment: Int, totalVat: Double, totalDiscount: Double, remainingPrice: Int, remaningFreeCargoPrice: Int, freeCargoPrice: Int, basketCargoMessage: String, couponCode: String, isGiftBox: Bool, refundGrandTotal: Double) {
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
        self.couponCode = couponCode
        self.isGiftBox = isGiftBox
        self.refundGrandTotal = refundGrandTotal
    }
}

class Address: Codable {
    let id, type, contactID, countryID: Int
    let cityID: Int
    let cityName: String
    let townID: Int
    let townName: String
    var areaID: Int? = nil
    var areaName: String? = nil
    let addressText, name: String
    var surname: String? = nil
    let nickName: String
    var taxOffice: String? = nil
    var taxNo: String? = nil
    let phone: String
    let identityNumber, recordDate: String
    var apartmentNo: String? = nil
    var nearestArea: String? = nil
    var postCode: String? = nil
    let receiver: String?
    var region: String? = nil
    
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
    
    init(id: Int, type: Int, contactID: Int, countryID: Int, cityID: Int, cityName: String, townID: Int, townName: String, areaID: Int, areaName: String, addressText: String, name: String, surname: String, nickName: String, taxOffice: String, taxNo: String, phone: String, identityNumber: String, recordDate: String, apartmentNo: String, nearestArea: String, postCode: String, receiver: String?, region: String) {
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
        self.receiver = receiver
        self.region = region
    }
}

class DataDetail: Codable {
    let productID, productDescriptionID: Int
    let uniqNo: String
    let quantity: Int
    let oldPrice, price: Double
    let barcode, code: String
    let status: Int
    var body: String? = nil
    var color: String? = nil
    let vatRatio: Int
    let vatTotal: Double
    let name: String
    let isOtherProduct, isCargo: Bool
    let discount: Double
    let productDiscount: Double
    let salePrice: Double
    var giftNote: String? = nil
    let mark: String
    let isGiftBox: Bool
    let image: GetOrderJSONNull?
    let imagePath: String
    let orderDetailFields: [JSONAny]
    
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
    
    init(productID: Int, productDescriptionID: Int, uniqNo: String, quantity: Int, oldPrice: Double, price: Double, barcode: String, code: String, status: Int, body: String, color: String, vatRatio: Int, vatTotal: Double, name: String, isOtherProduct: Bool, isCargo: Bool, discount: Double, productDiscount: Double, salePrice: Double, giftNote: String, mark: String, isGiftBox: Bool, image: GetOrderJSONNull?, imagePath: String, orderDetailFields: [JSONAny]) {
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

class Field: Codable {
    let id: Int
    let name: String
    let value: String
    let reference1, reference2: GetOrderJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case value = "Value"
        case reference1 = "Reference1"
        case reference2 = "Reference2"
    }
    
    init(id: Int, name: String, value: String, reference1: GetOrderJSONNull?, reference2: GetOrderJSONNull?) {
        self.id = id
        self.name = name
        self.value = value
        self.reference1 = reference1
        self.reference2 = reference2
    }
}

class Payment: Codable {
    let details: [PaymentDetail]
    let isDiscount: Bool
    var couponCode: String? = nil
    let totalPrice: Double
    var bankName: String? = nil
    var paymentTypeName: String? = nil
    let recordDate: String
    let installment: Int?
    
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
    
    init(details: [PaymentDetail], isDiscount: Bool, couponCode: String, totalPrice: Double, bankName: String, paymentTypeName: String, recordDate: String, installment: Int?) {
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

class PaymentDetail: Codable {
    let detailUniqNo: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case detailUniqNo = "DetailUniqNo"
        case price = "Price"
    }
    
    init(detailUniqNo: String, price: Double) {
        self.detailUniqNo = detailUniqNo
        self.price = price
    }
}

// MARK: Encode/decode helpers

class GetOrderJSONNull: Codable, Hashable {
    
    public static func == (lhs: GetOrderJSONNull, rhs: GetOrderJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetOrderJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
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

class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
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
            return GetOrderJSONNull()
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
                return GetOrderJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
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
                return GetOrderJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
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
            } else if value is GetOrderJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is GetOrderJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
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
        } else if value is GetOrderJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

func GetOrderNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetOrderNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetOrderNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetOrderResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetOrderResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

/*
import Foundation
import Alamofire

class GetOrderResult: Codable {
    let success: Bool
    let message: String
    let data: GetOrderData
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: GetOrderData) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetOrderData: Codable {
    let id: Int
    let dateTimeNow, saleCode: String
    let isBasket, isCancel, isValid, isStore: Bool
    let addresses: [Address]
    let details: [DataDetail]
    let groupDetails: [JSONAny]
    let payments: [Payment]
    let fields: [Field]
    let discounts: [Discount]
    let basketCreateDate, saleCreateDate: String
    let status: Int
    let saleNote: GetOrderJSONNull?
    let giftNote, cargoLink: String
    let subGrandTotal, subGrandTotalWithoutCargo, subGrandTotalWithProductDiscounts, grandTotal: Int
    let grandTotalWithoutCargo, totalProductDiscount, totalCouponDiscount, totalCampaignDiscount: Int
    let totalCargo, totalPayment: Int
    let totalVat: Double
    let totalDiscount, remainingPrice, remaningFreeCargoPrice, freeCargoPrice: Int
    let basketCargoMessage: String
    let couponCode: GetOrderJSONNull?
    let isGiftBox: Bool
    let refundGrandTotal: Double
    
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
        case couponCode = "CouponCode"
        case isGiftBox = "IsGiftBox"
        case refundGrandTotal = "RefundGrandTotal"
    }
    
    init(id: Int, dateTimeNow: String, saleCode: String, isBasket: Bool, isCancel: Bool, isValid: Bool, isStore: Bool, addresses: [Address], details: [DataDetail], groupDetails: [JSONAny], payments: [Payment], fields: [Field], discounts: [Discount], basketCreateDate: String, saleCreateDate: String, status: Int, saleNote: GetOrderJSONNull?, giftNote: String, cargoLink: String, subGrandTotal: Int, subGrandTotalWithoutCargo: Int, subGrandTotalWithProductDiscounts: Int, grandTotal: Int, grandTotalWithoutCargo: Int, totalProductDiscount: Int, totalCouponDiscount: Int, totalCampaignDiscount: Int, totalCargo: Int, totalPayment: Int, totalVat: Double, totalDiscount: Int, remainingPrice: Int, remaningFreeCargoPrice: Int, freeCargoPrice: Int, basketCargoMessage: String, couponCode: GetOrderJSONNull?, isGiftBox: Bool, refundGrandTotal: Double) {
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
        self.couponCode = couponCode
        self.isGiftBox = isGiftBox
        self.refundGrandTotal = refundGrandTotal
    }
}

class Address: Codable {
    let id, type, contactID, countryID: Int
    let cityID: Int
    let cityName: String
    let townID: Int
    let townName: String
    let areaID: Int
    let areaName, addressText, name: String
    let surname: GetOrderJSONNull?
    let nickName, taxOffice, taxNo, phone: String
    let identityNumber, recordDate: String
    let apartmentNo, nearestArea, postCode: GetOrderJSONNull?
    let receiver: String?
    let region: GetOrderJSONNull?
    
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
    
    init(id: Int, type: Int, contactID: Int, countryID: Int, cityID: Int, cityName: String, townID: Int, townName: String, areaID: Int, areaName: String, addressText: String, name: String, surname: GetOrderJSONNull?, nickName: String, taxOffice: String, taxNo: String, phone: String, identityNumber: String, recordDate: String, apartmentNo: GetOrderJSONNull?, nearestArea: GetOrderJSONNull?, postCode: GetOrderJSONNull?, receiver: String?, region: GetOrderJSONNull?) {
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
        self.receiver = receiver
        self.region = region
    }
}

class DataDetail: Codable {
    let productID, productDescriptionID: Int
    let uniqNo: String
    let quantity, oldPrice, price: Int
    let barcode, code: String
    let status: Int
    let body, color: String
    let vatRatio: Int
    let vatTotal: Double
    let name: String
    let isOtherProduct, isCargo: Bool
    let discount, productDiscount, salePrice: Int
    let giftNote: GetOrderJSONNull?
    let mark: String
    let isGiftBox: Bool
    let image: GetOrderJSONNull?
    let imagePath: String
    let orderDetailFields: [JSONAny]
    
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
    
    init(productID: Int, productDescriptionID: Int, uniqNo: String, quantity: Int, oldPrice: Int, price: Int, barcode: String, code: String, status: Int, body: String, color: String, vatRatio: Int, vatTotal: Double, name: String, isOtherProduct: Bool, isCargo: Bool, discount: Int, productDiscount: Int, salePrice: Int, giftNote: GetOrderJSONNull?, mark: String, isGiftBox: Bool, image: GetOrderJSONNull?, imagePath: String, orderDetailFields: [JSONAny]) {
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

class Discount: Codable {
    let name: String
    let grandTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case grandTotal = "GrandTotal"
    }
    
    init(name: String, grandTotal: Int) {
        self.name = name
        self.grandTotal = grandTotal
    }
}

class Field: Codable {
    let id: Int
    let name, value: String
    let reference1, reference2: GetOrderJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case value = "Value"
        case reference1 = "Reference1"
        case reference2 = "Reference2"
    }
    
    init(id: Int, name: String, value: String, reference1: GetOrderJSONNull?, reference2: GetOrderJSONNull?) {
        self.id = id
        self.name = name
        self.value = value
        self.reference1 = reference1
        self.reference2 = reference2
    }
}

class Payment: Codable {
    let details: [PaymentDetail]
    let isDiscount: Bool
    let couponCode: GetOrderJSONNull?
    let totalPrice: Double
    let bankName: String
    let paymentTypeName: GetOrderJSONNull?
    let recordDate: String
    let installment: Int?
    
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
    
    init(details: [PaymentDetail], isDiscount: Bool, couponCode: GetOrderJSONNull?, totalPrice: Double, bankName: String, paymentTypeName: GetOrderJSONNull?, recordDate: String, installment: Int?) {
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

class PaymentDetail: Codable {
    let detailUniqNo: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case detailUniqNo = "DetailUniqNo"
        case price = "Price"
    }
    
    init(detailUniqNo: String, price: Double) {
        self.detailUniqNo = detailUniqNo
        self.price = price
    }
}

// MARK: Encode/decode helpers

class GetOrderJSONNull: Codable, Hashable {
    
    public static func == (lhs: GetOrderJSONNull, rhs: GetOrderJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetOrderJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
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

class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
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
            return GetOrderJSONNull()
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
                return GetOrderJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
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
                return GetOrderJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
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
            } else if value is GetOrderJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is GetOrderJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
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
        } else if value is GetOrderJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

func GetOrderNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetOrderNewJSONEncoder() -> JSONEncoder {
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
            
            return Result { try GetOrderNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetOrderResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetOrderResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
*/
