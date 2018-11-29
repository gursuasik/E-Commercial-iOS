// To parse the JSON, add this file to your project and do:
//
//   let homePageResult = try? JSONDecoder().decode(HomePageResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseHomePageResult { response in
//     if let homePageResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class HomePageResult: Codable {
    let success: Bool
    let message: String
    let data: HomePageDataClass
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: HomePageDataClass) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class HomePageDataClass: Codable {
    let slider: [HomePageSlider]
    let leftMenu: [HomePageBanner]
    let menu: [HomePageJSONAny]
    let banner: [HomePageBanner]
    let h2Content: HomePageH2Content
    
    enum CodingKeys: String, CodingKey {
        case slider = "Slider"
        case leftMenu = "LeftMenu"
        case menu = "Menu"
        case banner = "Banner"
        case h2Content = "H2Content"
    }
    
    init(slider: [HomePageSlider], leftMenu: [HomePageBanner], menu: [HomePageJSONAny], banner: [HomePageBanner], h2Content: HomePageH2Content) {
        self.slider = slider
        self.leftMenu = leftMenu
        self.menu = menu
        self.banner = banner
        self.h2Content = h2Content
    }
}

class HomePageBanner: Codable {
    let field: HomePageH2Content
    let parentFields: [HomePageH2Content]
    
    enum CodingKeys: String, CodingKey {
        case field = "Field"
        case parentFields = "ParentFields"
    }
    
    init(field: HomePageH2Content, parentFields: [HomePageH2Content]) {
        self.field = field
        self.parentFields = parentFields
    }
}

class HomePageH2Content: Codable {
    let id, contentID: Int
    let name, value, type: String
    let reference1: String?
    let reference2: Reference2?
    let reference3, reference4, reference5: Reference?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case contentID = "ContentId"
        case name = "Name"
        case value = "Value"
        case type = "Type"
        case reference1 = "Reference1"
        case reference2 = "Reference2"
        case reference3 = "Reference3"
        case reference4 = "Reference4"
        case reference5 = "Reference5"
    }
    
    init(id: Int, contentID: Int, name: String, value: String, type: String, reference1: String?, reference2: Reference2?, reference3: Reference?, reference4: Reference?, reference5: Reference?) {
        self.id = id
        self.contentID = contentID
        self.name = name
        self.value = value
        self.type = type
        self.reference1 = reference1
        self.reference2 = reference2
        self.reference3 = reference3
        self.reference4 = reference4
        self.reference5 = reference5
    }
}

enum Reference2: String, Codable {
    case content = "Content"
    case empty = ""
    case null = "null"
}

enum Reference: String, Codable {
    case empty = ""
    case null = "null"
}

class HomePageSlider: Codable {
    let id, languageID: Int
    let title: String
    let spotText: String?
    let link: String
    let mainText: String?
    let metaTag: HomePageJSONNull?
    let smallImage, largeImage: String
    let metaKeyword: HomePageJSONNull?
    let fields: [HomePageH2Content]
    let reference1, reference2: HomePageJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case languageID = "LanguageId"
        case title = "Title"
        case spotText = "SpotText"
        case link = "Link"
        case mainText = "MainText"
        case metaTag = "MetaTag"
        case smallImage = "SmallImage"
        case largeImage = "LargeImage"
        case metaKeyword = "MetaKeyword"
        case fields = "Fields"
        case reference1 = "Reference1"
        case reference2 = "Reference2"
    }
    
    init(id: Int, languageID: Int, title: String, spotText: String?, link: String, mainText: String?, metaTag: HomePageJSONNull?, smallImage: String, largeImage: String, metaKeyword: HomePageJSONNull?, fields: [HomePageH2Content], reference1: HomePageJSONNull?, reference2: HomePageJSONNull?) {
        self.id = id
        self.languageID = languageID
        self.title = title
        self.spotText = spotText
        self.link = link
        self.mainText = mainText
        self.metaTag = metaTag
        self.smallImage = smallImage
        self.largeImage = largeImage
        self.metaKeyword = metaKeyword
        self.fields = fields
        self.reference1 = reference1
        self.reference2 = reference2
    }
}

// MARK: Encode/decode helpers

class HomePageJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(HomePageJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class HomePageJSONCodingKey: CodingKey {
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

class HomePageJSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(HomePageJSONAny.self, context)
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
            return HomePageJSONNull()
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
                return HomePageJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: HomePageJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<HomePageJSONCodingKey>, forKey key: HomePageJSONCodingKey) throws -> Any {
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
                return HomePageJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: HomePageJSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<HomePageJSONCodingKey>) throws -> [String: Any] {
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
            } else if value is HomePageJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: HomePageJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<HomePageJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = HomePageJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is HomePageJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: HomePageJSONCodingKey.self, forKey: key)
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
        } else if value is HomePageJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try HomePageJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: HomePageJSONCodingKey.self) {
            self.value = try HomePageJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try HomePageJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try HomePageJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: HomePageJSONCodingKey.self)
            try HomePageJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try HomePageJSONAny.encode(to: &container, value: self.value)
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
    func responseHomePageResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<HomePageResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

