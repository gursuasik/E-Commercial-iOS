//
//  GetProductDescriptionResult.swift
//  Master
//
//  Created by Gürsu Aşık on 7.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let getProductDescriptionResult = try? JSONDecoder().decode(GetProductDescriptionResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGetProductDescriptionResult { response in
//     if let getProductDescriptionResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class GetProductDescriptionResult: Codable {
    let success: Bool
    let message: String
    let data: GetProductDescriptionData
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: GetProductDescriptionData) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetProductDescriptionData: Codable {
    let id: Int
    let name: String
    var oldPrice: Double
    let price: Double
    let formattedPrice, formattedOldPrice, formattedGainAmount: String
    var title: String? = nil
    let explaination: String
    var secondExplaination: String? = nil
    var thirdExplaination: String? = nil
    var fourthExplaination: String? = nil
    let productCode, manufacturerCode: String
    let mark: GetProductDescriptionMark
    let vatRatio: Int
    let discountRatio: Double
    let reference3, recordDate: String
    let products: [GetProductDescriptionProduct]
    let relatedProducts: [GetProductDescriptionJSONAny]
    let images: [GetProductDescriptionImage]
    let tags: [GetProductDescriptionTag]
    let tagListJSON: [GetProductDescriptionTagListJSON]
    let departments: [GetProductDescriptionJSONAny]
    let reference1, stockExist: Bool
    let reference2: GetProductDescriptionJSONNull?
    let url: String
    let saleCount: Int
    let has360Images: Bool
    let firstDetail: String
    let isInFavoriteList, isDiscount, isNew: Bool
    let commentCount, commentAvaragePoint: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case oldPrice = "OldPrice"
        case price = "Price"
        case formattedPrice = "FormattedPrice"
        case formattedOldPrice = "FormattedOldPrice"
        case formattedGainAmount = "FormattedGainAmount"
        case title = "Title"
        case explaination = "Explaination"
        case secondExplaination = "SecondExplaination"
        case thirdExplaination = "ThirdExplaination"
        case fourthExplaination = "FourthExplaination"
        case productCode = "ProductCode"
        case manufacturerCode = "ManufacturerCode"
        case mark = "Mark"
        case vatRatio = "VatRatio"
        case discountRatio = "DiscountRatio"
        case reference3 = "Reference3"
        case recordDate = "RecordDate"
        case products = "Products"
        case relatedProducts = "RelatedProducts"
        case images = "Images"
        case tags = "Tags"
        case tagListJSON = "TagListJson"
        case departments = "Departments"
        case reference1 = "Reference1"
        case stockExist = "StockExist"
        case reference2 = "Reference2"
        case url = "Url"
        case saleCount = "SaleCount"
        case has360Images = "Has360Images"
        case firstDetail = "FirstDetail"
        case isInFavoriteList = "IsInFavoriteList"
        case isDiscount = "IsDiscount"
        case isNew = "IsNew"
        case commentCount = "CommentCount"
        case commentAvaragePoint = "CommentAvaragePoint"
    }
    
    init(id: Int, name: String, oldPrice: Double, price: Double, formattedPrice: String, formattedOldPrice: String, formattedGainAmount: String, title: String? = nil, explaination: String, secondExplaination: String? = nil, thirdExplaination: String? = nil, fourthExplaination: String? = nil, productCode: String, manufacturerCode: String, mark: GetProductDescriptionMark, vatRatio: Int, discountRatio: Double, reference3: String, recordDate: String, products: [GetProductDescriptionProduct], relatedProducts: [GetProductDescriptionJSONAny], images: [GetProductDescriptionImage], tags: [GetProductDescriptionTag], tagListJSON: [GetProductDescriptionTagListJSON], departments: [GetProductDescriptionJSONAny], reference1: Bool, stockExist: Bool, reference2: GetProductDescriptionJSONNull?, url: String, saleCount: Int, has360Images: Bool, firstDetail: String, isInFavoriteList: Bool, isDiscount: Bool, isNew: Bool, commentCount: Int, commentAvaragePoint: Int) {
        self.id = id
        self.name = name
        self.oldPrice = oldPrice
        self.price = price
        self.formattedPrice = formattedPrice
        self.formattedOldPrice = formattedOldPrice
        self.formattedGainAmount = formattedGainAmount
        self.title = title
        self.explaination = explaination
        self.secondExplaination = secondExplaination
        self.thirdExplaination = thirdExplaination
        self.fourthExplaination = fourthExplaination
        self.productCode = productCode
        self.manufacturerCode = manufacturerCode
        self.mark = mark
        self.vatRatio = vatRatio
        self.discountRatio = discountRatio
        self.reference3 = reference3
        self.recordDate = recordDate
        self.products = products
        self.relatedProducts = relatedProducts
        self.images = images
        self.tags = tags
        self.tagListJSON = tagListJSON
        self.departments = departments
        self.reference1 = reference1
        self.stockExist = stockExist
        self.reference2 = reference2
        self.url = url
        self.saleCount = saleCount
        self.has360Images = has360Images
        self.firstDetail = firstDetail
        self.isInFavoriteList = isInFavoriteList
        self.isDiscount = isDiscount
        self.isNew = isNew
        self.commentCount = commentCount
        self.commentAvaragePoint = commentAvaragePoint
    }
}

class GetProductDescriptionImage: Codable {
    let fileName, description: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case fileName = "FileName"
        case description = "Description"
        case order = "Order"
    }
    
    init(fileName: String, description: String, order: Int) {
        self.fileName = fileName
        self.description = description
        self.order = order
    }
}

class GetProductDescriptionMark: Codable {
    let id: Int
    let name, reference1, reference2, reference3: GetProductDescriptionJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case reference1 = "Reference1"
        case reference2 = "Reference2"
        case reference3 = "Reference3"
    }
    
    init(id: Int, name: GetProductDescriptionJSONNull?, reference1: GetProductDescriptionJSONNull?, reference2: GetProductDescriptionJSONNull?, reference3: GetProductDescriptionJSONNull?) {
        self.id = id
        self.name = name
        self.reference1 = reference1
        self.reference2 = reference2
        self.reference3 = reference3
    }
}

class GetProductDescriptionProduct: Codable {
    let id: Int
    let name: String
    let bodyID: Int
    let body: String
    let colorID: Int
    let color: String
    let oldPrice: Decimal
    let barcode: String
    let price: Decimal
    let stock, storeStock, productDescriptionID: Int
    let productCode: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case bodyID = "BodyId"
        case body = "Body"
        case colorID = "ColorId"
        case color = "Color"
        case oldPrice = "OldPrice"
        case barcode = "Barcode"
        case price = "Price"
        case stock = "Stock"
        case storeStock = "StoreStock"
        case productDescriptionID = "ProductDescriptionId"
        case productCode = "ProductCode"
    }
    
    init(id: Int, name: String, bodyID: Int, body: String, colorID: Int, color: String, oldPrice: Decimal, barcode: String, price: Decimal, stock: Int, storeStock: Int, productDescriptionID: Int, productCode: String) {
        self.id = id
        self.name = name
        self.bodyID = bodyID
        self.body = body
        self.colorID = colorID
        self.color = color
        self.oldPrice = oldPrice
        self.barcode = barcode
        self.price = price
        self.stock = stock
        self.storeStock = storeStock
        self.productDescriptionID = productDescriptionID
        self.productCode = productCode
    }
}

class GetProductDescriptionTagListJSON: Codable {
    let groupID: Int
    let groupName: String
    let id: Int
    let name: String
    let colorCode: String?
    let groupOrder, order: Int
    
    enum CodingKeys: String, CodingKey {
        case groupID = "GroupId"
        case groupName = "GroupName"
        case id = "Id"
        case name = "Name"
        case colorCode = "ColorCode"
        case groupOrder = "GroupOrder"
        case order = "Order"
    }
    
    init(groupID: Int, groupName: String, id: Int, name: String, colorCode: String?, groupOrder: Int, order: Int) {
        self.groupID = groupID
        self.groupName = groupName
        self.id = id
        self.name = name
        self.colorCode = colorCode
        self.groupOrder = groupOrder
        self.order = order
    }
}

class GetProductDescriptionTag: Codable {
    let id: Int
    let groupName, name: String
    let orderNumber: Int
    let colorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case groupName = "GroupName"
        case name = "Name"
        case orderNumber = "OrderNumber"
        case colorCode = "ColorCode"
    }
    
    init(id: Int, groupName: String, name: String, orderNumber: Int, colorCode: String?) {
        self.id = id
        self.groupName = groupName
        self.name = name
        self.orderNumber = orderNumber
        self.colorCode = colorCode
    }
}

// MARK: Encode/decode helpers

class GetProductDescriptionJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(GetProductDescriptionJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class GetProductDescriptionJSONCodingKey: CodingKey {
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

class GetProductDescriptionJSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(GetProductDescriptionJSONAny.self, context)
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
            return GetProductDescriptionJSONNull()
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
                return GetProductDescriptionJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: GetProductDescriptionJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<GetProductDescriptionJSONCodingKey>, forKey key: GetProductDescriptionJSONCodingKey) throws -> Any {
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
                return GetProductDescriptionJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: GetProductDescriptionJSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<GetProductDescriptionJSONCodingKey>) throws -> [String: Any] {
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
            } else if value is GetProductDescriptionJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: GetProductDescriptionJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<GetProductDescriptionJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = GetProductDescriptionJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is GetProductDescriptionJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: GetProductDescriptionJSONCodingKey.self, forKey: key)
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
        } else if value is GetProductDescriptionJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try GetProductDescriptionJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: GetProductDescriptionJSONCodingKey.self) {
            self.value = try GetProductDescriptionJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try GetProductDescriptionJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try GetProductDescriptionJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: GetProductDescriptionJSONCodingKey.self)
            try GetProductDescriptionJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try GetProductDescriptionJSONAny.encode(to: &container, value: self.value)
        }
    }
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetProductDescriptionResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetProductDescriptionResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
