// To parse the JSON, add this file to your project and do:
//
//   let searchResult = try? JSONDecoder().decode(SearchResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSearchResult { response in
//     if let searchResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class SearchResult: Codable {
    let success: Bool
    let message: String
    let data: SearchDataClass
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: SearchDataClass) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class SearchDataClass: Codable {
    let id: Int
    var parentID: Int? = nil
    var url: String? = nil
    let name: String
    var title: String? = nil
    var htmlContent: String? = nil
    var metaTag: String? = nil
    let productListCount, totalProductCount, listingType: Int
    let products: [SearchProduct]
    let markList, tagList, specList: [SearchList]
    let explanation, explanation1: SearchSearchJSONNull?
    var explanation2: String? = nil
    var explanation3: String? = nil
    var isCriteria: Bool? = nil
    var criteria: String? = nil
    let minPrice, maxPrice: Int
    let tagGroup, specGroup: [SearchGroup]
    let imagePath, iconLogoPath: SearchSearchJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case parentID = "ParentId"
        case url = "Url"
        case name = "Name"
        case title = "Title"
        case htmlContent = "HtmlContent"
        case metaTag = "MetaTag"
        case productListCount = "ProductListCount"
        case totalProductCount = "TotalProductCount"
        case listingType = "ListingType"
        case products = "Products"
        case markList = "MarkList"
        case tagList = "TagList"
        case specList = "SpecList"
        case explanation = "Explanation"
        case explanation1 = "Explanation1"
        case explanation2 = "Explanation2"
        case explanation3 = "Explanation3"
        case isCriteria = "IsCriteria"
        case criteria = "Criteria"
        case minPrice = "MinPrice"
        case maxPrice = "MaxPrice"
        case tagGroup = "TagGroup"
        case specGroup = "SpecGroup"
        case imagePath = "ImagePath"
        case iconLogoPath = "IconLogoPath"
    }
    
    init(id: Int, parentID: Int? = nil, url: String? = nil, name: String, title: String? = nil, htmlContent: String? = nil, metaTag: String? = nil, productListCount: Int, totalProductCount: Int, listingType: Int, products: [SearchProduct], markList: [SearchList], tagList: [SearchList], specList: [SearchList], explanation: SearchSearchJSONNull?, explanation1: SearchSearchJSONNull?, explanation2: String? = nil, explanation3: String? = nil, isCriteria: Bool? = nil, criteria: String? = nil, minPrice: Int, maxPrice: Int, tagGroup: [SearchGroup], specGroup: [SearchGroup], imagePath: SearchSearchJSONNull?, iconLogoPath: SearchSearchJSONNull?) {
        self.id = id
        self.parentID = parentID
        self.url = url
        self.name = name
        self.title = title
        self.htmlContent = htmlContent
        self.metaTag = metaTag
        self.productListCount = productListCount
        self.totalProductCount = totalProductCount
        self.listingType = listingType
        self.products = products
        self.markList = markList
        self.tagList = tagList
        self.specList = specList
        self.explanation = explanation
        self.explanation1 = explanation1
        self.explanation2 = explanation2
        self.explanation3 = explanation3
        self.isCriteria = isCriteria
        self.criteria = criteria
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.tagGroup = tagGroup
        self.specGroup = specGroup
        self.imagePath = imagePath
        self.iconLogoPath = iconLogoPath
    }
}

class SearchList: Codable {
    let name: String?
    let orderNumber, groupOrderNumber, type: Int
    let id: String
    let select: Bool
    let count: Int
    let groupName: String?
    let groupID: Int
    let iconImage: String?
    let colorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case orderNumber = "OrderNumber"
        case groupOrderNumber = "GroupOrderNumber"
        case type = "Type"
        case id = "Id"
        case select = "Select"
        case count = "Count"
        case groupName = "GroupName"
        case groupID = "GroupId"
        case iconImage = "IconImage"
        case colorCode = "ColorCode"
    }
    
    init(name: String?, orderNumber: Int, groupOrderNumber: Int, type: Int, id: String, select: Bool, count: Int, groupName: String?, groupID: Int, iconImage: String?, colorCode: String?) {
        self.name = name
        self.orderNumber = orderNumber
        self.groupOrderNumber = groupOrderNumber
        self.type = type
        self.id = id
        self.select = select
        self.count = count
        self.groupName = groupName
        self.groupID = groupID
        self.iconImage = iconImage
        self.colorCode = colorCode
    }
}

class SearchProduct: Codable {
    let id: Int
    let name, productCode, manufactureCode, detail: String
    let firstDetail: String
    let tags: [String]
    let tagListJSON: [SearchTagList]
    let specsJSON: [SearchSpecsJSON]
    let specs: [String]
    let date, activationDate: String
    let activationDateNumeric, saleCount, displayCount: Int
    let price: Double
    let vatRatio, point: Int
    let nPoint: String
    let priceInput: Int
    let segmentOldPrice: Double
    let oldPrice: Int
    let isNew, isDiscount: Bool
    let mainImage, mainImageDescription: String
    let markID, stock, storeStock, totalStock: Int
    let markName, productURL, markKey, reference1: String
    let reference3: String
    let order: Int
    let departments: [Int]
    let segmentPrice: SearchSegmentPrice
    let secondImage: String
    let priceRatio: Int
    let priceRangeID, gender, genderID: String
    let isFastCargo, stockExist: Bool
    let colorName, colorIconImage, searchName: String
    let sortName: SearchSearchJSONNull?
    let likedCount: String
    let discountRatio, season: Int
    let imageList, imageListWithOrder: [String]
    let productType, productTypeKey: String
    let productTypeID: Int
    let explaination: String
    let isOnShow: Bool
    let tagList: [SearchTagList]
    let barcode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case productCode = "ProductCode"
        case manufactureCode = "ManufactureCode"
        case detail = "Detail"
        case firstDetail = "FirstDetail"
        case tags = "Tags"
        case tagListJSON = "TagListJson"
        case specsJSON = "SpecsJson"
        case specs = "Specs"
        case date = "Date"
        case activationDate = "ActivationDate"
        case activationDateNumeric = "ActivationDateNumeric"
        case saleCount = "SaleCount"
        case displayCount = "DisplayCount"
        case price = "Price"
        case vatRatio = "VatRatio"
        case point = "Point"
        case nPoint = "NPoint"
        case priceInput = "PriceInput"
        case segmentOldPrice = "SegmentOldPrice"
        case oldPrice = "OldPrice"
        case isNew = "IsNew"
        case isDiscount = "IsDiscount"
        case mainImage = "MainImage"
        case mainImageDescription = "MainImageDescription"
        case markID = "MarkId"
        case stock = "Stock"
        case storeStock = "StoreStock"
        case totalStock = "TotalStock"
        case markName = "MarkName"
        case productURL = "ProductUrl"
        case markKey = "MarkKey"
        case reference1 = "Reference1"
        case reference3 = "Reference3"
        case order = "Order"
        case departments = "Departments"
        case segmentPrice = "SegmentPrice"
        case secondImage = "SecondImage"
        case priceRatio = "PriceRatio"
        case priceRangeID = "PriceRangeId"
        case gender = "Gender"
        case genderID = "GenderId"
        case isFastCargo = "IsFastCargo"
        case stockExist = "StockExist"
        case colorName = "ColorName"
        case colorIconImage = "ColorIconImage"
        case searchName = "SearchName"
        case sortName = "SortName"
        case likedCount = "LikedCount"
        case discountRatio = "DiscountRatio"
        case season = "Season"
        case imageList = "ImageList"
        case imageListWithOrder = "ImageListWithOrder"
        case productType = "ProductType"
        case productTypeKey = "ProductTypeKey"
        case productTypeID = "ProductTypeId"
        case explaination = "Explaination"
        case isOnShow = "IsOnShow"
        case tagList = "TagList"
        case barcode = "Barcode"
    }
    
    init(id: Int, name: String, productCode: String, manufactureCode: String, detail: String, firstDetail: String, tags: [String], tagListJSON: [SearchTagList], specsJSON: [SearchSpecsJSON], specs: [String], date: String, activationDate: String, activationDateNumeric: Int, saleCount: Int, displayCount: Int, price: Double, vatRatio: Int, point: Int, nPoint: String, priceInput: Int, segmentOldPrice: Double, oldPrice: Int, isNew: Bool, isDiscount: Bool, mainImage: String, mainImageDescription: String, markID: Int, stock: Int, storeStock: Int, totalStock: Int, markName: String, productURL: String, markKey: String, reference1: String, reference3: String, order: Int, departments: [Int], segmentPrice: SearchSegmentPrice, secondImage: String, priceRatio: Int, priceRangeID: String, gender: String, genderID: String, isFastCargo: Bool, stockExist: Bool, colorName: String, colorIconImage: String, searchName: String, sortName: SearchSearchJSONNull?, likedCount: String, discountRatio: Int, season: Int, imageList: [String], imageListWithOrder: [String], productType: String, productTypeKey: String, productTypeID: Int, explaination: String, isOnShow: Bool, tagList: [SearchTagList], barcode: String?) {
        self.id = id
        self.name = name
        self.productCode = productCode
        self.manufactureCode = manufactureCode
        self.detail = detail
        self.firstDetail = firstDetail
        self.tags = tags
        self.tagListJSON = tagListJSON
        self.specsJSON = specsJSON
        self.specs = specs
        self.date = date
        self.activationDate = activationDate
        self.activationDateNumeric = activationDateNumeric
        self.saleCount = saleCount
        self.displayCount = displayCount
        self.price = price
        self.vatRatio = vatRatio
        self.point = point
        self.nPoint = nPoint
        self.priceInput = priceInput
        self.segmentOldPrice = segmentOldPrice
        self.oldPrice = oldPrice
        self.isNew = isNew
        self.isDiscount = isDiscount
        self.mainImage = mainImage
        self.mainImageDescription = mainImageDescription
        self.markID = markID
        self.stock = stock
        self.storeStock = storeStock
        self.totalStock = totalStock
        self.markName = markName
        self.productURL = productURL
        self.markKey = markKey
        self.reference1 = reference1
        self.reference3 = reference3
        self.order = order
        self.departments = departments
        self.segmentPrice = segmentPrice
        self.secondImage = secondImage
        self.priceRatio = priceRatio
        self.priceRangeID = priceRangeID
        self.gender = gender
        self.genderID = genderID
        self.isFastCargo = isFastCargo
        self.stockExist = stockExist
        self.colorName = colorName
        self.colorIconImage = colorIconImage
        self.searchName = searchName
        self.sortName = sortName
        self.likedCount = likedCount
        self.discountRatio = discountRatio
        self.season = season
        self.imageList = imageList
        self.imageListWithOrder = imageListWithOrder
        self.productType = productType
        self.productTypeKey = productTypeKey
        self.productTypeID = productTypeID
        self.explaination = explaination
        self.isOnShow = isOnShow
        self.tagList = tagList
        self.barcode = barcode
    }
}

class SearchSegmentPrice: Codable {
    
    init() {
    }
}

class SearchSpecsJSON: Codable {
    let id: Int
    let name: String
    let order, specialityTypeID: Int
    let typeName: String
    let typeOrder: Int
    let iconImage: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case order = "Order"
        case specialityTypeID = "SpecialityTypeId"
        case typeName = "TypeName"
        case typeOrder = "TypeOrder"
        case iconImage = "IconImage"
    }
    
    init(id: Int, name: String, order: Int, specialityTypeID: Int, typeName: String, typeOrder: Int, iconImage: String) {
        self.id = id
        self.name = name
        self.order = order
        self.specialityTypeID = specialityTypeID
        self.typeName = typeName
        self.typeOrder = typeOrder
        self.iconImage = iconImage
    }
}

class SearchTagList: Codable {
    let groupID: Int
    let groupName: String?
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
    
    init(groupID: Int, groupName: String?, id: Int, name: String, colorCode: String?, groupOrder: Int, order: Int) {
        self.groupID = groupID
        self.groupName = groupName
        self.id = id
        self.name = name
        self.colorCode = colorCode
        self.groupOrder = groupOrder
        self.order = order
    }
}

class SearchGroup: Codable {
    let list: [SearchList]
    let id: Int
    let name: String?
    let count, order: Int
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
        case id = "Id"
        case name = "Name"
        case count = "Count"
        case order = "Order"
    }
    
    init(list: [SearchList], id: Int, name: String?, count: Int, order: Int) {
        self.list = list
        self.id = id
        self.name = name
        self.count = count
        self.order = order
    }
}

// MARK: Encode/decode helpers

class SearchSearchJSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(SearchSearchJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
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
    func responseSearchResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SearchResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
